import 'package:cervivorbd/widgets/cc_intro_grid_menu.dart';
import 'package:cervivorbd/widgets/center_grid_menu.dart';
import 'package:cervivorbd/widgets/text_button.dart';
import 'package:cervivorbd/widgets/top_doctors_list.dart';
import 'package:flutter/material.dart';

class   HomeTabPage extends StatefulWidget {
  const  HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;
  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
            Text(
              'জরায়ুর ক্যান্সার সম্পর্কে জানুন',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            const CCIntroGridMenu(),
            const SizedBox(
              height: 24,
            ),
            Text(
              'বাংলাদেশে স্ক্রিনিং সেন্টারগুলো সম্পর্কে জানুন',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 5,
            ),
            const CenterGridMenu(),
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