import 'package:cervivorbd/Screens/UserProfiles/Doctor/top_doctor_vertical_list.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

class TreatmentTabPage extends StatefulWidget {
  const TreatmentTabPage({Key? key}) : super(key: key);

  @override
  _TreatmentTabPageState createState() => _TreatmentTabPageState();
}

class _TreatmentTabPageState extends State<TreatmentTabPage> {
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
          length: 4,
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: kdarkPink,
                        borderRadius: BorderRadius.circular(10.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        icon: Icon(FontAwesomeIcons.userDoctor),
                        text: 'ডাক্তার',
                      ),
                      Tab(
                        icon: Icon(FontAwesomeIcons.solidHospital),
                        text: 'হাসপাতাল',
                      ),
                      Tab(
                        icon: Icon(FontAwesomeIcons.calendar),
                        text: 'অ্যাপয়েন্ট',
                      ),
                      Tab(
                        icon: Icon(FontAwesomeIcons.prescription),
                        // text: 'প্রেসক্রিপশন',
                        text: 'ওষুধ',
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
                      child: const DoctorList(),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Container(),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: const MyAppointmentList(),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Container(),
                    ),
                  ],
                ))
              ],
            ),
          )),
        ));
  }
}
