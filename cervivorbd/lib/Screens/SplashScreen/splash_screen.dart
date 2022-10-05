import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const SignupScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPink,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Image.asset('images/beware-0.png'),
                  // Container(
                  //   height: h / 20,
                  //   width: double.infinity,
                  //   decoration: const BoxDecoration(
                  //       color: Colors.white,
                  //       image: DecorationImage(
                  //         fit: BoxFit.contain,
                  //         image: AssetImage('images/logoheader.png'),
                  //       )),
                  // ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'স্বাগতম!',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CCIntroGridMenu(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomLeft,
                          child: ElevatedButton2(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => const SignupScreen()));
                              },
                              label: 'নিবন্ধন করুন',
                              icon: Icons.person_add),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: ElevatedButton2(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => const LoginScreen()));
                              },
                              label: 'লগইন করুন',
                              icon: Icons.login),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
