import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Widgets/Appbar/appbar2.dart';
import 'package:cervivorbd/Utils/Widgets/PopUp/popup_item_body.dart';
import 'package:cervivorbd/Utils/Widgets/PopUp/popup_item_launcher.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  int selectedIndex = 0;
  int initialIndex = 0;
  MainScreen(
      {Key? key, required this.selectedIndex, required this.initialIndex})
      : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  onItemClicked(int index) {
    setState(() {
      widget.selectedIndex = index;
      tabController!.index = widget.selectedIndex;
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  Patient loggedInUser = Patient();
  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          loggedInUser = Patient.fromMap(value.data());
          // call setState to rebuild the view
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    tabController = TabController(
        initialIndex: widget.initialIndex, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: user != null
              ? Appbar2(
                  username: loggedInUser.fullname,
                  propicURL: 'assets/images/nazia.png')
              : Appbar3(),
        ),
        drawer: Drawer2(uid: loggedInUser.uid),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            const HomeTabPage(),
            const Screening(),
            user != null ? const TreatmentTabPage() : const LoginScreen(),
            user != null ? const ForumTabPage() : const LoginScreen(),
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
                icon: Icon(FontAwesomeIcons.stethoscope), label: "চিকিৎসা"),
            BottomNavigationBarItem(
                icon: Icon(Icons.forum), label: "পাব্লিক ফোরাম"),
          ],
          unselectedItemColor: kBlackColor900,
          selectedItemColor: kdarkPink,
          backgroundColor: kPink,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 14),
          showUnselectedLabels: true,
          currentIndex: widget.selectedIndex,
          onTap: onItemClicked,
        ));
  }
}
