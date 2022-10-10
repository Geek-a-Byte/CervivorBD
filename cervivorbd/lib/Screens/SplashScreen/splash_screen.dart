import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Widgets/Buttons/module_intro.dart';

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
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPink,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  // Container(
                  //   height: h / 8,
                  //   width: double.infinity,
                  //   decoration: const BoxDecoration(
                  //       color: Colors.white,
                  //       image: DecorationImage(
                  //         fit: BoxFit.contain,
                  //         image: AssetImage('assets/images/logoheader.png'),
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
                    child: ModuleIntroGridMenu(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
