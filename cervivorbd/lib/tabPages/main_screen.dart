import 'package:cervivorbd/Modules/CancerScreening/Screening.dart';
import 'package:cervivorbd/tabPages/forum_screen.dart';
import 'package:cervivorbd/tabPages/home_screen.dart';
import 'package:cervivorbd/widgets/appbar.dart';
import 'package:cervivorbd/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../color_constants.dart';
import 'my_appointments_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
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
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: const Appbar2(),
        drawer: const Drawer2(),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            HomeTabPage(),
            Screening(),
            AppointmentTabPage(),
            ForumTabPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "হোম",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.vial,
                ),
                label: "প্রাথমিক স্ক্রিনিং"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: "অ্যাপয়েন্টসমূহ"),
            BottomNavigationBarItem(icon: Icon(Icons.forum), label: "পাব্লিক ফোরাম"),
          ],
          unselectedItemColor: kBlackColor900,
          selectedItemColor: kdarkPink,
          backgroundColor: kPink,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 14),
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onItemClicked,
        ));
  }
}
