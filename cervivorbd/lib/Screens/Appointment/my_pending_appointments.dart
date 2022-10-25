import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Theme/color_constants.dart';
import 'package:intl/intl.dart';

class MyAppointmentList extends StatefulWidget {
  const MyAppointmentList({Key? key}) : super(key: key);

  @override
  _MyAppointmentListState createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  String? loggedInUserType;
  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _documentID;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> deleteAppointment(String docID) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc(user!.email.toString())
        .collection('pending')
        .doc(docID)
        .delete();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        deleteAppointment(_documentID!);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this Appointment?"),
      actions: [
        cancelButton,
        continueButton,
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

  Future<void> _getUser() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          loggedInUserType = value['userType'];
          // call setState to rebuild the view
        });
      });
    }
  }

  String _dateFormatter(String _timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _timeFormatter(String _timestamp) {
    String formattedTime =
        DateFormat('kk:mm').format(DateTime.parse(_timestamp));
    return formattedTime;
  }

  _checkDiff(DateTime _date) {
    var diff = DateTime.now().difference(_date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String _date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(_date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  _compareAppointmentApprovalStatus(bool approvedOrNot) {
    if (approvedOrNot == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String usertype = loggedInUserType == 'Doctor' ? 'Doctors' : 'Patients';
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(usertype)
            .doc(user!.uid)
            .collection('appointments')
            .orderBy('date')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.size == 0
              ? Center(
                  child: Text(
                    'No Appointment Scheduled',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    if (_checkDiff(document['date'].toDate())) {
                      deleteAppointment(document.id);
                    }
                    return Card(
                        elevation: 2,
                        child: InkWell(
                            onTap: () {},
                            child: ExpansionTile(
                                title: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        loggedInUserType == 'Doctor'
                                            ? document['patient']
                                            : document['doctor'],
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        _compareDate(document['date']
                                                .toDate()
                                                .toString())
                                            ? "TODAY"
                                            : "",
                                        style: GoogleFonts.lato(
                                            color: Colors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                subtitle: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Appointment Date: ' +
                                            _dateFormatter(document['date']
                                                .toDate()
                                                .toString()),
                                        style: GoogleFonts.lato(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      _compareAppointmentApprovalStatus(
                                              document['approvalStatus'])
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                "Approved",
                                                style: GoogleFonts.lato(
                                                    color: Colors.green,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                "Pending Approval",
                                                style: GoogleFonts.lato(
                                                    color: Colors.orange,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, right: 10, left: 16),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Appointed to: " +
                                                        document['doctor'],
                                                    style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Patient name: " +
                                                        document['patient'],
                                                    style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Patient phone: " +
                                                        document['phone'],
                                                    style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Appointment Time: " +
                                                        _timeFormatter(
                                                          document['date']
                                                              .toDate()
                                                              .toString(),
                                                        ),
                                                    style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  _compareAppointmentApprovalStatus(
                                                              !document[
                                                                  'approvalStatus']) &&
                                                          usertype == "Doctors"
                                                      ? Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                              child: ElevatedButton
                                                                  .icon(
                                                                      onPressed:
                                                                          () {
                                                                        document
                                                                            .reference
                                                                            .update({
                                                                          'approvalStatus':
                                                                              true
                                                                        });
                                                          
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'Patients')
                                                                            .doc(document[
                                                                                'patientUID'])
                                                                            .collection(
                                                                                'appointments')
                                                                            .doc(document['doctorUID'] +
                                                                                ' ' +
                                                                                document['date']
                                                                                    .toDate()
                                                                                    .toString())
                                                                            .update({
                                                                          'approvalStatus':
                                                                              true
                                                                        });
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                          elevation:
                                                                              0,
                                                                          primary:
                                                                              kGreenLightColor),
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              15,
                                                                          color: Colors
                                                                              .black),
                                                                      label:
                                                                          Text(
                                                                        'Approve',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline4!
                                                                            .copyWith(color: kGreenColor),
                                                                      )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                              child: ElevatedButton
                                                                  .icon(
                                                                      onPressed:
                                                                          () {
                                                                        _documentID =
                                                                            document.id;
                                                                        showAlertDialog(
                                                                            context);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        elevation:
                                                                            0,
                                                                        primary: const Color.fromARGB(
                                                                            255,
                                                                            241,
                                                                            105,
                                                                            95),
                                                                      ),
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .delete,
                                                                          size:
                                                                              15,
                                                                          color: Colors
                                                                              .black),
                                                                      label:
                                                                          Text(
                                                                        'Cancel',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline4!
                                                                            .copyWith(color: const Color.fromARGB(255, 91, 13, 8)),
                                                                      )),
                                                            ),
                                                          ],
                                                        )
                                                      : Container()
                                                ])
                                          ]))
                                ])));
                  },
                );
        },
      ),
    );
  }
}
