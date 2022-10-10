import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

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
  UserModel loggedInUser = UserModel();
  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          loggedInUser = UserModel.fromMap(value.data());
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
        appBar: user != null
            ? Appbar2(
                username: loggedInUser.fullname,
                propicURL: 'assets/images/nazia.png')
            : AppBar(
                flexibleSpace: const Padding(
                  padding: EdgeInsets.only(left: 45.0, top: 10.0),
                  child: Image(
                    alignment: Alignment.topLeft,
                    image: AssetImage('assets/images/logoheader.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: kBlackColor900),
              ),
        drawer: const Drawer2(),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            const HomeTabPage(),
            const Screening(),
            user != null ? const AppointmentTabPage() : const LoginScreen(),
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
          currentIndex: widget.selectedIndex,
          onTap: onItemClicked,
        ));
  }
}
