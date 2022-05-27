import 'package:flutter/material.dart';

class Appbar2 extends StatelessWidget with PreferredSizeWidget {
  const Appbar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Center(
          child: Text("CervivorBD",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        backgroundColor: Colors.black,
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
