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
  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    const _kFontFam = 'MyFlutterApp';
    const String? _kFontPkg = null;
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
              body: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0)),
                child: const TabBar(
                  indicator: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.03, 0.02],
                          colors: [kBlackColor900, kdarkPink]),
                      color: kdarkPink,
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      icon: Icon(FontAwesomeIcons.userDoctor),
                      text: 'ডাক্তার',
                    ),
                    Tab(
                      icon: Icon(IconData(0xf0f8,
                          fontFamily: _kFontFam, fontPackage: _kFontPkg)),
                      text: 'হাসপাতাল',
                    ),
                    Tab(
                      icon: Icon(FontAwesomeIcons.calendar),
                      text: 'অ্যাপয়েন্ট',
                    ),
                  ],
                ),
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
                ],
              ))
            ],
          )),
        ));
  }
}
