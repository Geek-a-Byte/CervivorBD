import 'package:cervivorbd/mainScreens/main_screen.dart';
import 'package:cervivorbd/widgets/elevated_button.dart';
import 'package:cervivorbd/widgets/heading.dart';
import 'package:cervivorbd/widgets/text_button.dart';
import 'package:cervivorbd/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  validateForm() {
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(emailTextEditingController.text)) {
      Fluttertoast.showToast(msg: "email address is not valid");
    } else if (emailTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "email is required");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "password is required");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(
          msg: "password must be at least 6 characters long");
    } else {
      signIn(emailTextEditingController.text, passwordTextEditingController.text);
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
                    Heading(
                      label: "লগইন করুন",
                    ),
                    TextFormField2(
                        controller: emailTextEditingController,
                        label: 'ইমেইল*'),
                    TextFormField2(
                        controller: passwordTextEditingController,
                        label: 'পাসওয়ার্ড*'),
                    ElevatedButton2(
                      onPressed: () {
                        validateForm();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (c) => const MainScreen()));
                      },
                      label: "লগইন",
                    ),
                    TextButton2(
                        label: "অ্যাকাউন্ট নেই? নিবন্ধন করুন",
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          // builder: (c) => const LoginScreen()));
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  String? errorMessage;
  // login function
  void signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MainScreen())),
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
}
