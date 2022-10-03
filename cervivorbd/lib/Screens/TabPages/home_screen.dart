import 'package:cervivorbd/Screens/CancerInformationModule/cc_intro_grid_menu.dart';
import 'package:cervivorbd/Screens/UserProfiles/Doctor/top_doctors_list.dart';
import 'package:cervivorbd/Utils/Widgets/Buttons/intro_button.dart';
import 'package:cervivorbd/Utils/Widgets/Buttons/text_button.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with SingleTickerProviderStateMixin {
  // User? user = FirebaseAuth.instance.currentUser;
  // UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((value) {
    //   loggedInUser = UserModel.fromMap(value.data());
    // });
  }

  // TabController? tabController;
  // int selectedIndex = 0;
  // onItemClicked(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //     tabController!.index = selectedIndex;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            // "${loggedInUser.firstName} ${loggedInUser.secondName}"
            // Text(
            //   'স্বাগতম ${loggedInUser.fullname}!',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            Text(
              'জরায়ুর ক্যান্সার সম্পর্কে জানুন',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 10,
            ),
            const CCIntroGridMenu(),
            const SizedBox(
              height: 15,
            ),
            Text(
              'বাংলাদেশে স্ক্রিনিং সেন্টারগুলো সম্পর্কে জানুন',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[0],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[1],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[2],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[3],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[4],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[5],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[6],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'বিশেষজ্ঞ ডাক্তারগণ',
                  style: Theme.of(context).textTheme.headline5,
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

            // const CenterGridMenu(),
          ]),
        ),
      )),
    );
  }
}
