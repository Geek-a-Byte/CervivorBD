import 'package:cervivorbd/models/patient.dart';
import 'package:cervivorbd/widgets/cc_intro_grid_menu.dart';
import 'package:cervivorbd/widgets/center_grid_menu.dart';
import 'package:cervivorbd/widgets/text_button.dart';
import 'package:cervivorbd/widgets/top_doctors_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/popup_item_launcher.dart';
import '../widgets/popup_item_body.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with SingleTickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    tabController = TabController(length: 3, vsync: this);
  }

  TabController? tabController;
  int selectedIndex = 0;
  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const SizedBox(
              height: 12,
            ),
            // "${loggedInUser.firstName} ${loggedInUser.secondName}"
            Text(
              'স্বাগতম ${loggedInUser.fullname}!',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'জরায়ুর ক্যান্সার সম্পর্কে জানুন',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            const CCIntroGridMenu(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'বিশেষজ্ঞ ডাক্তারগণ',
                  style: Theme.of(context).textTheme.headline4,
                ),
                TextButton2(
                    label: 'সব দেখুন',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      // builder: (c) => const LoginScreen()));
                    }),
              ],
            ),
            const TopDoctorsList(),
            const SizedBox(
              height: 24,
            ),

            Text(
              'বাংলাদেশে স্ক্রিনিং সেন্টারগুলো সম্পর্কে জানুন',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            const CenterGridMenu(),
            // PopupItemLauncher(
            //   tag: 'test',
            //   child: Material(
            //     color: Colors.white,
            //     elevation: 2,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(32)),
            //     child: const Icon(
            //       Icons.add_rounded,
            //       size: 56,
            //     ),
            //   ),
            //   popUp: PopUpItem(
            //     padding: const EdgeInsets.all(8), // Padding inside of the card
            //     color: Colors.white, // Color of the card
            //     shape: RoundedRectangleBorder(
            //         borderRadius:
            //             BorderRadius.circular(32)), // Shape of the card
            //     elevation: 2, // Elevation of the card
            //     tag: 'test', // MUST BE THE SAME AS IN `PopupItemLauncher`
            //     child: const PopUpItemBody(), // Your custom child widget.
            //   ),
            // ),
          ]),
        ),
      )),
    );
  }
}

// RichText(
//     text: TextSpan(
//         style: Theme.of(context).textTheme.headline1,
//         children: <TextSpan>[
//       const TextSpan(
//         text: 'Find',
//       ),
//       TextSpan(
//         text: ' your doctor',
//         style: Theme.of(context)
//             .textTheme
//             .headline1!
//             .copyWith(color: kGreyColor800),
//       ),
//     ])),