import 'package:cervivorbd/Screens/Authentication/login_screen.dart';
import 'package:cervivorbd/Screens/TabPages/main_screen.dart';
import 'package:cervivorbd/Screens/UserProfiles/Patient/patient.dart';
import 'package:cervivorbd/Utils/Widgets/Buttons/elevated_button.dart';
import 'package:cervivorbd/Utils/Widgets/Buttons/text_button.dart';
import 'package:cervivorbd/utils/Widgets/TextStyle/heading.dart';
import 'package:cervivorbd/utils/Widgets/TextStyle/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 2 characters long");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email address is not valid");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "phone number is mandatory");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(
          msg: "password must be at least 6 characters long");
    } else {
      signUp(
          emailTextEditingController.text, passwordTextEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFF6FC),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.025,
                top: MediaQuery.of(context).size.height * 0,
                bottom: MediaQuery.of(context).size.height * 0,
                right: MediaQuery.of(context).size.height * 0.025,
              ),
              child: Column(
                children: [
                  Image.asset('images/logo.png', width: w, height: h * 0.28),
                  Heading(label: "ফ্রিতে নিবন্ধন করুন"),
                  TextFormField2(
                      controller: nameTextEditingController, label: 'নাম*'),
                  TextFormField2(
                      controller: emailTextEditingController, label: 'ইমেইল*'),
                  TextFormField2(
                      controller: passwordTextEditingController,
                      label: 'পাসওয়ার্ড*'),
                  TextFormField2(
                      controller: phoneTextEditingController,
                      label: 'ফোন নম্বর*'),
                  ElevatedButton2(
                      onPressed: () {
                        validateForm();
                      },
                      label: "নিবন্ধন করুন"),
                  TextButton2(
                      label: "অ্যাকাউন্ট আছে? লগইন করুন",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                        builder: (c) => const LoginScreen()));
                      }),
                ],
              ),
            ),
          ),
        )));
  }

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  void signUp(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = nameTextEditingController.text;
    userModel.phonenumber = phoneTextEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (c) => const LoginScreen()));
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false);
  }
}
