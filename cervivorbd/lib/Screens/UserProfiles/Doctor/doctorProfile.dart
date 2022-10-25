// ignore_for_file: file_names

import 'package:cervivorbd/Screens/Appointment/appointment.dart';
import 'package:cervivorbd/Utils/Widgets/Appbar/appbar3.dart';
import 'package:cervivorbd/Utils/Widgets/TextStyle/text_box_display.dart';
import 'package:intl/intl.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

import '../../../Utils/Widgets/Buttons/available_hours_grid.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  List<String>? availableHours;
  TimeOfDay currentTime = TimeOfDay.now();
  late String dateTime;
  late String dateUTC;
  Doctor? doctor;
  Patient loggedInUser = Patient();
  DateTime selectedDate = DateTime.now();
  String timeText = 'Select Time';
  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    print(_timeController.text);
    String s = _timeController.text;
    TimeOfDay? selectedTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    // await showTimePicker(
    //   context: context,
    //   initialTime: currentTime,
    // );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime,
        alwaysUse24HourFormat: false);

    setState(() {
      timeText = formattedTime;
      _timeController.text = timeText;
    });
    dateTime = selectedTime.toString().substring(10, 15);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TreatmentTabPage(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Done!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Appointment is registered.",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget showAvailableHours(
      BuildContext context, Future<List<double>> availableHours) {
    return DoctorAvailableHoursGrid(availableHours: availableHours);
  }

  loadAvailableHours(
      BuildContext context, DateTime date, String doctorUID) async {
    String dateString = DateFormat('yyyy-MM-dd').format(date);
    print(dateString);
    final activeHours = [
      '09:00',
      '09:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '12:00',
      '12:30',
      '13:00'
    ];
    var busyHours = [];
    await FirebaseFirestore.instance
        .collection("Doctors")
        .doc(doctorUID)
        .collection("busyHours")
        .doc(dateString)
        .get()
        .then((value) {
      if (value.data() != null) {
        setState(() {
          busyHours = value.data()!["busyTime"];
          print(busyHours);
        });
      }
    });
    var set1 = Set.from(activeHours);
    var set2 = Set.from(busyHours);
    print(set1);
    print(set2);
    setState(() {
      availableHours = List.from(set1.difference(set2));
    });

    print(availableHours);
    // return availableHours;
  }

  validateAppointmentForm() {
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Please login to the app before booking an appointment.");
    } else if (loggedInUser.toString() != "Instance of 'Patient'") {
      print(loggedInUser.toString());
      Fluttertoast.showToast(
          msg:
              "You can't take an appointment as a doctor, please sign in as a patient.");
    } else if (_descriptionController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Reason/Description of your problem is mandatory");
    } else if (_dateController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a date for the appointment.");
    } else if (_timeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a time for the appointment.");
    } else {
      showAlertDialog(context);
      _createAppointment();
    }
  }

  Future<void> _getUser() async {
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

  Future<void> _createAppointment() async {
    Appointment appointmentModel = Appointment();
    appointmentModel.approvalStatus = false;
    appointmentModel.patientUID = loggedInUser.uid;
    appointmentModel.doctorUID = doctor!.uid;
    appointmentModel.patient = loggedInUser.fullname;
    appointmentModel.phone = loggedInUser.phonenumber;
    appointmentModel.description = _descriptionController.text;
    appointmentModel.doctor = _doctorController.text;
    appointmentModel.date = DateTime.parse(dateUTC + ' ' + dateTime + ':00');
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(user!.uid)
          .collection('appointments')
          .doc(doctor!.uid! + ' ' + appointmentModel.date.toString())
          .set(appointmentModel.toMapAppointment());
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctor!.uid)
          .collection('appointments')
          .doc(user!.uid + ' ' + appointmentModel.date.toString())
          .set(appointmentModel.toMapAppointment());
      var list = [dateTime];
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctor!.uid)
          .collection('busyHours')
          .doc(dateUTC)
          .set({"busyTime": FieldValue.arrayUnion(list)},
              SetOptions(merge: true));
      // var list = [_timeController.text];
      // FirebaseFirestore.instance
      //     .collection("Doctors")
      //     .doc(doctor!.uid)
      //     .collection("busyHours")
      //     .doc(dateUTC)
      //     .update({"busyTime": FieldValue.arrayUnion(list)});
      // await FirebaseFirestore.instance
      //     .collection('appointments')
      //     .doc(user!.email)
      //     .collection('pending')
      //     .doc()
      //     .set(appointmentModel.toMapAppointment());
      // await FirebaseFirestore.instance
      //     .collection('appointments')
      //     .doc(user!.email)
      //     .collection('all')
      //     .doc()
      //     .set(appointmentModel.toMapAppointment());
      _nameController.clear();
      _phoneController.clear();
      _descriptionController.clear();
      _dateController.clear();
      _timeController.clear();
      availableHours!.clear();
      Fluttertoast.showToast(msg: "appointment created successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget rerender = DoctorAvailableHoursGrid(availableHours: availableHours!);
    doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
    _doctorController.text = doctor!.fullname!;
    TextEditingController emailTextEditingController = TextEditingController();
    TextEditingController passwordTextEditingController =
        TextEditingController();

    final _auth = FirebaseAuth.instance;

    String? errorMessage;
    // login function
    void signIn(String email, String password) async {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(selectedIndex: 0, initialIndex: 0))),
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

    validateLoginForm() {
      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
          .hasMatch(emailTextEditingController.text)) {
        Fluttertoast.showToast(msg: "email address is not valid");
      } else if (emailTextEditingController.text.isEmpty) {
        Fluttertoast.showToast(msg: "email is required");
      } else if (passwordTextEditingController.text.isEmpty) {
        Fluttertoast.showToast(msg: "password is required");
      } else if (passwordTextEditingController.text.length < 6) {
        Fluttertoast.showToast(
            msg: "password must be at least 6 characters long");
      } else {
        signIn(emailTextEditingController.text,
            passwordTextEditingController.text);
      }
    }

    return Scaffold(
        appBar: Appbar4(label: 'Doctor Details'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Container(
                color: Colors.transparent,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'assets/images/${doctor!.doctorPicture}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Container(
                          width: 88,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/${doctor!.doctorPicture!}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: doctor!.fullname!,
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                doctor!.fullname!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                          Text(
                            '${doctor!.doctorSpeciality} • ${doctor!.doctorHospital}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 136,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 24,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: doctor!.doctorIsOpen!
                                        ? kGreenLightColor
                                        : kRedLightColor,
                                  ),
                                  child: Text(
                                    doctor!.doctorIsOpen!
                                        ? 'Available'
                                        : 'Not Available',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: doctor!.doctorIsOpen!
                                              ? kGreenColor
                                              : kRedColor,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'পেশাগত অভিজ্ঞতা',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    doctor!.doctorDescription!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'কর্মঘণ্টা',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    doctor!.doctorStartWorkingHour!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    doctor!.doctorEndWorkingHour!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  user == null
                      ? Column(
                          children: [
                            Text(
                              'অ্যাপয়েন্ট বুকিং এর জন্য প্রথমে লগইন করুন',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(height: 10),
                            TextFormField2(
                                controller: emailTextEditingController,
                                label: 'ইমেইল*'),
                            const SizedBox(height: 10),
                            TextFormField2(
                                controller: passwordTextEditingController,
                                label: 'পাসওয়ার্ড*'),
                            const SizedBox(height: 10),
                            ElevatedButton2(
                              icon: Icons.login_outlined,
                              onPressed: () {
                                validateLoginForm();
                              },
                              label: "লগইন",
                            ),
                            const SizedBox(height: 10),
                            TextButton2(
                                label: "অ্যাকাউন্ট নেই? নিবন্ধন করুন",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) =>
                                              const SignupScreen()));
                                  // Navigator.popAndPushNamed(context, '/signup');
                                }),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              'অ্যাপয়েন্ট বুকিং এর জন্য পেশেন্টের ডিটেলস দিন',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(height: 10),
                            Form(
                              key: _formKey,
                              child: Container(
                                padding: const EdgeInsets.only(top: 0),
                                child: Column(children: [
                                  TextDisplayBox(
                                      label: 'ডাক্তারের নাম *',
                                      value: doctor!.fullname!),
                                  TextDisplayBox(
                                      label: 'পেশেন্টের নাম *',
                                      value: loggedInUser.fullname),
                                  TextDisplayBox(
                                      label: 'পেশেন্টের ফোন নম্বর*',
                                      value: loggedInUser.phonenumber),
                                  TextFormField2(
                                      controller: _descriptionController,
                                      label: 'সমস্যার বিবরণ*'),
                                  const SizedBox(height: 10),
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextFormField2(
                                          controller: _dateController,
                                          label: 'অ্যাপয়েন্টমেন্টের তারিখ*'),
                                      const SizedBox(height: 10),
                                      ClipOval(
                                        child: Material(
                                          color: kdarkPink, // button color
                                          child: InkWell(
                                            // inkwell color
                                            child: const SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.date_range_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              selectDate(context);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  ElevatedButton2(
                                      label: "Check available hours",
                                      icon: Icons.hourglass_bottom,
                                      onPressed: () async {
                                        setState(() {
                                          loadAvailableHours(
                                              context,
                                              DateFormat('dd-MM-yyyy')
                                                  .parse(_dateController.text),
                                              doctor!.uid!);
                                        });
                                      }),
                                  availableHours == null ||
                                          _dateController.text == ''
                                      ? Container()
                                      : Column(
                                          children: [
                                            GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 2,
                                              ),
                                              padding: EdgeInsets.zero,
                                              itemCount: availableHours!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return OutlinedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _timeController.text =
                                                          availableHours![index]
                                                              .toString();
                                                      selectTime(context);
                                                    });
                                                  },
                                                  child: SizedBox(
                                                    height: 300,
                                                    width: double.infinity,
                                                    // decoration: BoxDecoration(
                                                    //     borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                    //     image: DecorationImage(
                                                    //         colorFilter: ColorFilter.mode(
                                                    //             const Color.fromARGB(255, 52, 1, 27).withOpacity(0.8),
                                                    //             BlendMode.darken),
                                                    //         fit: BoxFit.cover,
                                                    //         image: AssetImage(introPhotoMenu[index]))),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text(
                                                            availableHours![
                                                                    index]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    kBlackColor900)),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            TextDisplayBox(
                                                value: _timeController.text,
                                                label:
                                                    'অ্যাপয়েন্টমেন্টের সময়*'),
                                            ElevatedButton2(
                                                label:
                                                    "অ্যাপয়েন্ট কনফার্ম করুন",
                                                onPressed: () {
                                                  validateAppointmentForm();
                                                },
                                                icon: Icons.done_outline),
                                          ],
                                        ),
                                  // Stack(
                                  //   alignment: Alignment.centerRight,
                                  //   children: [

                                  //     ClipOval(
                                  //       child: Material(
                                  //         color: kdarkPink, // button color
                                  //         child: InkWell(
                                  //           // inkwell color
                                  //           child: const SizedBox(
                                  //             width: 40,
                                  //             height: 40,
                                  //             child: Icon(
                                  //               Icons.timer_outlined,
                                  //               color: Colors.white,
                                  //             ),
                                  //           ),
                                  //           onTap: () {
                                  //             selectTime(context);
                                  //           },
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ]),
          ),
        ));
  }
}
