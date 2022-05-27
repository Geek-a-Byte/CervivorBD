import 'package:cervivorbd/mainScreens/main_screen.dart';
import 'package:cervivorbd/widgets/elevated_button.dart';
import 'package:cervivorbd/widgets/heading.dart';
import 'package:cervivorbd/widgets/text_button.dart';
import 'package:cervivorbd/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
                Heading(label: "লগইন করুন",),
                TextFormField2(
                    controller: emailTextEditingController, label: 'ইমেইল*'),
                TextFormField2(
                    controller: passwordTextEditingController, label: 'পাসওয়ার্ড*'),
                ElevatedButton2(
                    onPressed: () {
                      // validateForm();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => const MainScreen()));
                    },
                    label:  "লগইন",
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
        )
      );
  }
}
