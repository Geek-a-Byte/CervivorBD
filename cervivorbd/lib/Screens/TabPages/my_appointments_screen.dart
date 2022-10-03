import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';


class AppointmentTabPage extends StatefulWidget {
  const AppointmentTabPage({Key? key}) : super(key: key);

  @override
  _AppointmentTabPageState createState() => _AppointmentTabPageState();
}

class _AppointmentTabPageState extends State<AppointmentTabPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                 const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: kdarkPink,
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'আসন্ন অ্যাপয়েন্টসমূহ',
                      ),
                      Tab(
                        text: 'বিগত অ্যাপয়েন্টসমূহ',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: MyAppointmentList(),
                    ),
                     Container(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: const AppointmentHistoryList(),
                    ),
                  ],
                ))
              ],
            ),
          )),
        )
        );
  }
}
