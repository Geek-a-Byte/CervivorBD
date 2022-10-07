// ignore_for_file: file_names

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
                        style: Theme.of(context).textTheme.headline5,
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
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                '(${doctor.doctorDescription})',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'কর্মঘণ্টা',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.left,
              ),
              Text(
                '(${doctor.doctorWorkingHour})',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'অ্যাপয়েন্ট বুকিং এর জন্য পেশেন্টের ডিটেলস দিন',
                style: Theme.of(context).textTheme.headline5,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(children: [
                    TextFormField2(
                        controller: _nameController, label: 'পেশেন্টের নাম *'),
                    TextFormField2(
                        controller: _phoneController,
                        label: 'পেশেন্টের ফোন নম্বর*'),
                    TextFormField2(
                        controller: _descriptionController,
                        label: 'সমস্যার বিবরণ*'),
                    Container(
                      alignment: Alignment.center,
                      height: 68,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField2(
                              controller: _dateController,
                              label: 'অ্যাপয়েন্টমেন্টের তারিখ*'),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ClipOval(
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
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 68,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField2(
                              controller: _timeController,
                              label: 'অ্যাপয়েন্টমেন্টের সময়*'),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ClipOval(
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
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton2(
                      label: "অ্যাপয়েন্ট কনফার্ম করুন",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showAlertDialog(context);
                          _createAppointment();
                        }
                      },
                    ),
                  ]),
                ),
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
              //   style: Theme.of(context).textTheme.headline5,
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

  Future<void> _createAppointment() async {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc(user!.email)
        .collection('pending')
        .doc()
        .set({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'doctor': _doctorController.text,
      'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
    }, SetOptions(merge: true));

    FirebaseFirestore.instance
        .collection('appointments')
        .doc(user!.email)
        .collection('all')
        .doc()
        .set({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'doctor': _doctorController.text,
      'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
    }, SetOptions(merge: true));
  }
}
