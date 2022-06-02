import 'package:cervivorbd/doctor_app_theme.dart';
import 'package:cervivorbd/Profiles/doctorProfile.dart';
import 'package:cervivorbd/tabPages/main_screen.dart';
import 'package:cervivorbd/splashScreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isSignedIn => _auth.currentUser != null;

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: MaterialApp(
        theme: DoctorAppTheme.lightTheme,
        // home: Screening(),
        debugShowCheckedModeBanner: false,
        // home: Consumer<AuthModel>(
        //   builder: (_, auth, __) =>
        //       auth.isSignedIn ? const MainScreen() : const MySplashScreen(),
        // ),
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<AuthModel>(
                builder: (_, auth, __) => auth.isSignedIn
                    ? const MainScreen()
                    : const MySplashScreen(),
              ),
          '/doctor_details': (context) => const DoctorDetailScreen(),
        },
      ),
    ),
  );
  // runApp(
  //   MyApp(
  //     child: MaterialApp(
  //       // theme: ThemeData(
  //       //   primarySwatch: Colors.pink,
  //       // ),
  //       theme: DoctorAppTheme.lightTheme,
  //       // home: Screening(),
  //       debugShowCheckedModeBanner: false,
  //       initialRoute: '/',
  //       routes: {
  //         '/': (context) => const MySplashScreen(),
  //         '/doctor_details': (context) => const DoctorDetailScreen(),
  //       },
  //     ),
  //   ),
  // );
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
