import 'package:cervivorbd/color_constants.dart';
import 'package:cervivorbd/models/doctor.dart';
import 'package:cervivorbd/widgets/appointment_option_menu.dart';
import 'package:cervivorbd/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
  // select date time picker

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    final time = await _selectTime(context);
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH: ss a').format(dateTime);
    }
  }

  String getTime(TimeOfDay tod) {
    final now = DateTime.now();

    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
    return Scaffold(
        body: Padding(
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
                        image: AssetImage(
                          'images/${doctor.doctorPicture}',
                        ),
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
                                  ? 'Avilable'
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
              '(${doctor.doctorDescription})',
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
              '(${doctor.doctorWorkingHour})',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'অ্যাপয়েন্ট বুক করুন',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () {
                  _selectDateTime(context);
                  showDateTime = true;
                },
                child: const Text('ডেট পিক করুন *'),
              ),
            ),
            showDateTime
                ? Center(child: Text(getDateTime()))
                : const SizedBox(),
            const SizedBox(
              height: 12,
            ),
            Text(
              'অ্যাপয়েন্টের অপশন বাছাই করুন',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 12,
            ),
            const OptionGridMenu(),
            Center(
                child: ElevatedButton2(
                    onPressed: () {}, label: 'অ্যাপয়েন্টের জন্য পেমেন্ট করুন')),
          ],
        ),
      ]),
    ));
  }
}
