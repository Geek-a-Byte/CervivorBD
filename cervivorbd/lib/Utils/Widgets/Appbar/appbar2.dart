// ignore_for_file: must_be_immutable

import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Theme/color_constants.dart';
import 'package:cervivorbd/Utils/Widgets/Buttons/login_signup_appbar.dart';
import 'package:flutter/material.dart';

class Appbar3 extends StatelessWidget with PreferredSizeWidget {
  Appbar3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: ClipOval(
            child: Material(
              color: Colors.black, // Button color
              child: InkWell(
                splashColor: kdarkPink, // Splash color
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.menu, color: Colors.white, size: 20)),
              ),
            ),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      centerTitle: false,
      title: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
        child: const SizedBox(
          height: 30,
          child: Image(
            alignment: Alignment.topLeft,
            image: AssetImage('assets/images/logoheader.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: kBlackColor900),
      actions: <Widget>[
        Padding(
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: Row(
              children: [
                loginSignupButton(
                    label: 'লগইন',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const LoginScreen()));
                    },
                    icon: Icons.login_outlined),
                const SizedBox(width: 10),
                loginSignupButton(
                    label: 'রেজিস্টার',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const SignupScreen()));
                    },
                    icon: Icons.app_registration_outlined)
              ],
            )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
