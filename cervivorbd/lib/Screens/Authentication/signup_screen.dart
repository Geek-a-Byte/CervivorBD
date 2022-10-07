import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //patient
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  //doctor
  TextEditingController doctorNameTextEditingController =
      TextEditingController();
  TextEditingController doctorEmailTextEditingController =
      TextEditingController();
  TextEditingController doctorPasswordTextEditingController =
      TextEditingController();
  TextEditingController doctorPhoneTextEditingController =
      TextEditingController();
  TextEditingController doctorDescriptionTextEditingController =
      TextEditingController();
  TextEditingController doctorHospitalTextEditingController =
      TextEditingController();
  TextEditingController doctorSpecialityTextEditingController =
      TextEditingController();
  TextEditingController doctorWorkinghourTextEditingController =
      TextEditingController();
  TextEditingController doctorYearofExperinenceTextEditingController =
      TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 2 characters long");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email address is not valid");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "phone number is mandatory");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(
          msg: "password must be at least 6 characters long");
    } else {
      signUp(
          emailTextEditingController.text, passwordTextEditingController.text);
    }
  }

  String dropdownValue = 'Patient';
  Widget _renderWidget(dropdownValue) {
    if (dropdownValue == 'Patient') {
      return Column(
        children: [
          TextFormField2(controller: nameTextEditingController, label: 'নাম*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: emailTextEditingController, label: 'ইমেইল*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: passwordTextEditingController, label: 'পাসওয়ার্ড*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: phoneTextEditingController, label: 'ফোন নম্বর*'),
          const SizedBox(height: 10),
          ElevatedButton2(
              icon: Icons.app_registration,
              onPressed: () {
                validateForm();
              },
              label: "নিবন্ধন করুন"),
        ],
      );
    } else {
      return Column(
        children: [
          TextFormField2(
              controller: doctorNameTextEditingController, label: 'নাম*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorEmailTextEditingController, label: 'ইমেইল*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorPasswordTextEditingController,
              label: 'পাসওয়ার্ড*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorPhoneTextEditingController,
              label: 'ফোন নম্বর*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorDescriptionTextEditingController,
              label: 'পেশাগত অভিজ্ঞতার বিবরণ*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorHospitalTextEditingController,
              label: 'বর্তমানে যে হাসপাতালে চাকরি করছেন*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorSpecialityTextEditingController,
              label: 'বিভাগ*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorWorkinghourTextEditingController,
              label: 'কর্মঘণ্টা*'),
          const SizedBox(height: 10),
          TextFormField2(
              controller: doctorWorkinghourTextEditingController,
              label: 'চাকরির সময়ব্যাপ্তি*'),
          const SizedBox(height: 10),
          ElevatedButton2(
              icon: Icons.app_registration,
              onPressed: () {
                validateForm();
              },
              label: "নিবন্ধন করুন"),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFF6FC),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.025,
                top: MediaQuery.of(context).size.height * 0,
                bottom: MediaQuery.of(context).size.height * 0,
                right: MediaQuery.of(context).size.height * 0.025,
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png',
                      width: w, height: h * 0.28),
                  Heading(label: "ফ্রিতে নিবন্ধন করুন"),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(color: kdarkPink, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(color: kdarkPink, width: 0.5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Colors.white,
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Doctor', 'Patient']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  _renderWidget(dropdownValue)
                  // TextButton2(
                  //     label: "অ্যাকাউন্ট আছে? লগইন করুন",
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (c) => const LoginScreen()));
                  //       // Navigator.popAndPushNamed(context, '/login');
                  //     }),
                ],
              ),
            ),
          ),
        )));
  }

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  void signUp(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = nameTextEditingController.text;
    userModel.phonenumber = phoneTextEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (c) => const LoginScreen()));
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false);
  }
}
