// ignore_for_file: file_names

import 'package:cervivorbd/Screens/Appointment/appointment.dart';
import 'package:intl/intl.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  // DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay.now();
  // DateTime dateTime = DateTime.now();
  // bool showDate = false;
  // bool showTime = false;
  // bool showDateTime = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select Time';
  late String dateUTC;
  late String dateTime;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
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
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime!,
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
            builder: (context) => const AppointmentTabPage(),
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

  @override
  void initState() {
    super.initState();
    _getUser();
    selectTime(context);
  }

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
    _doctorController.text = doctor.doctorName;

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
                      builder: (context) => const MainScreen())),
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
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            color: Colors.transparent,
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'images/${doctor.doctorPicture}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: 88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(doctor.doctorPicture),
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
                        tag: doctor.doctorName,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            doctor.doctorName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      Text(
                        '${doctor.doctorSpecialty} • ${doctor.doctorHospital}',
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
                            Row(
                              children: [
                                RatingBar.builder(
                                  itemSize: 16,
                                  initialRating: double.parse(
                                    doctor.doctorRating,
                                  ),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.zero,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: kYellowColor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    debugPrint(rating.toString());
                                  },
                                  unratedColor: kGreyColor600,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '(${doctor.doctorNumberOfPatient})',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            Container(
                              height: 24,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: doctor.doctorIsOpen
                                    ? kGreenLightColor
                                    : kRedLightColor,
                              ),
                              child: Text(
                                doctor.doctorIsOpen
                                    ? 'Available'
                                    : 'Not Available',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: doctor.doctorIsOpen
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
                doctor.doctorDescription,
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
                doctor.doctorWorkingHour,
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
                                      builder: (c) => const SignupScreen()));
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
                              TextFormField2(
                                  controller: _nameController,
                                  label: 'পেশেন্টের নাম *'),
                              const SizedBox(height: 10),
                              TextFormField2(
                                  controller: _phoneController,
                                  label: 'পেশেন্টের ফোন নম্বর*'),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextFormField2(
                                      controller: _timeController,
                                      label: 'অ্যাপয়েন্টমেন্টের সময়*'),
                                  ClipOval(
                                    child: Material(
                                      color: kdarkPink, // button color
                                      child: InkWell(
                                        // inkwell color
                                        child: const SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Icon(
                                            Icons.timer_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          selectTime(context);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton2(
                                  label: "অ্যাপয়েন্ট কনফার্ম করুন",
                                  onPressed: () {
                                    validateForm();
                                  },
                                  icon: Icons.done_outline),
                            ]),
                          ),
                        ),
                      ],
                    ),
              // const SizedBox(
              //   height: 12,
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         primary: Colors.black,
              //         textStyle: const TextStyle(
              //             fontSize: 15, fontWeight: FontWeight.bold)),
              //     onPressed: () {
              //       _selectDateTime(context);
              //       showDateTime = true;
              //     },
              //     child: const Text('ডেট পিক করুন *'),
              //   ),
              // ),
              // showDateTime
              //     ? Center(child: Text(getDateTime()))
              //     : const SizedBox(),
              // const SizedBox(
              //   height: 12,
              // ),
              // Text(
              //   'অ্যাপয়েন্টের অপশন বাছাই করুন',
              //   style: Theme.of(context).textTheme.headline4,
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              // const OptionGridMenu(),
              // Center(
              //     child: ElevatedButton2(
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) =>
              //                     BookingScreen(doctor: doctor.doctorName)),
              //           );
              //         },
              //         label: 'অ্যাপয়েন্টের জন্য পেমেন্ট করুন')),
            ],
          ),
        ]),
      ),
    ));
  }

  validateForm() {
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Please login to the app before booking an appointment.");
    } else if (_nameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please provide your username registered in this app.");
    } else if (_phoneController.text.length != 11) {
      Fluttertoast.showToast(msg: "Please provide a valid phone number.");
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

  Future<void> _createAppointment() async {
    Appointment appointmentModel = Appointment();
    appointmentModel.name = _nameController.text;
    appointmentModel.phone = _phoneController.text;
    appointmentModel.description = _descriptionController.text;
    appointmentModel.doctor = _doctorController.text;
    appointmentModel.date = DateTime.parse(dateUTC + ' ' + dateTime + ':00');
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(user!.email)
          .collection('pending')
          .doc()
          .set(appointmentModel.toMapAppointment());
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(user!.email)
          .collection('all')
          .doc()
          .set(appointmentModel.toMapAppointment());
      _nameController.clear();
      _phoneController.clear();
      _descriptionController.clear();
      _dateController.clear();
      _timeController.clear();
      Fluttertoast.showToast(msg: "appointment created successfully!");
    }
  }
}
