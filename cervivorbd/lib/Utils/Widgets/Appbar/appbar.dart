import 'package:cervivorbd/Utils/Theme/color_constants.dart';
import 'package:flutter/material.dart';

class Appbar2 extends StatelessWidget with PreferredSizeWidget {
  const Appbar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // title: const Text("CervivorBD",
        //     style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18)),
        flexibleSpace: const Padding(
          padding: EdgeInsets.only(left: 45.0, top: 30.0),
          child: Image(
            alignment: Alignment.topLeft,
            image: AssetImage('images/logoheader.png'),
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kBlackColor900),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: 36,
              height: 36,
              child: CircleAvatar(
                backgroundImage: AssetImage('images/nazia.png'),
              ),
            ),
          )
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
