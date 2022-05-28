import 'package:cervivorbd/CancerScreening/Screening.dart';
import 'package:cervivorbd/doctor_app_theme.dart';
import 'package:cervivorbd/mainScreens/doctor_detail_screen.dart';
import 'package:cervivorbd/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MyApp(
      child: MaterialApp(
        // theme: ThemeData(
        //   primarySwatch: Colors.pink,
        // ),
        theme: DoctorAppTheme.lightTheme,
        // home: Screening(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MySplashScreen(),
          '/doctor_details': (context) => const DoctorDetailScreen(),
        },
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;
  // ignore: use_key_in_widget_constructors
  const MyApp({this.child});
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child!);
  }
}
