import 'package:cervivorbd/authentication/login_screen.dart';
import 'package:cervivorbd/splashScreen/splash_screen.dart';
import 'package:cervivorbd/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

import '../widgets/heading.dart';
import '../widgets/text_button.dart';
import '../widgets/text_form_field.dart';

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
                        // validateForm();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const LoginScreen()));
                      },
                      label: "নিবন্ধন করুন"),
                  TextButton2(
                      label: "অ্যাকাউন্ট আছে? লগইন করুন",
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
        )
      )
    );
  }
}
