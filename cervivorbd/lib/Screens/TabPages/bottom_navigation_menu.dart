import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/main.dart';
import 'package:provider/provider.dart';

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
          children: [
            const HomeTabPage(),
            const Screening(),
            // AppointmentTabPage(),
            // ForumTabPage(),
            Consumer<AuthModel>(
              builder: (_, auth, __) => auth.isSignedIn
                  ? const AppointmentTabPage()
                  : const LoginScreen(),
            ),
            Consumer<AuthModel>(
              builder: (_, auth, __) =>
                  auth.isSignedIn ? const ForumTabPage() : const LoginScreen(),
            ),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.forum), label: "পাব্লিক ফোরাম"),
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