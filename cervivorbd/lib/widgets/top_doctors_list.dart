import 'package:cervivorbd/models/doctor.dart';
import 'package:cervivorbd/widgets/top_doctor_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopDoctorsList extends StatelessWidget {
  const TopDoctorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('doctors')
                .orderBy('rating', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                  height: h * 0.37,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: topDoctors.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doctor = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed('/doctor_details',
                          //     arguments: Doctor(
                          //       doctorName: topDoctors[index].doctorName,
                          //       doctorDescription:
                          //           topDoctors[index].doctorDescription,
                          //       doctorHospital:
                          //           topDoctors[index].doctorHospital,
                          //       doctorIsOpen: topDoctors[index].doctorIsOpen,
                          //       doctorNumberOfPatient:
                          //           topDoctors[index].doctorNumberOfPatient,
                          //       doctorPicture: topDoctors[index].doctorPicture,
                          //       doctorRating: topDoctors[index].doctorRating,
                          //       doctorSpecialty:
                          //           topDoctors[index].doctorSpecialty,
                          //       doctorYearOfExperience:
                          //           topDoctors[index].doctorYearOfExperience,
                          //       doctorWorkingHour:
                          //           topDoctors[index].doctorWorkingHour,
                          //     ));
                          Navigator.of(context).pushNamed(
                            '/doctor_details',
                            arguments: Doctor(
                              doctorName: doctor['name'],
                              doctorDescription: doctor['description'],
                              doctorHospital: doctor['hospital'],
                              doctorIsOpen: doctor['IsOpen'],
                              doctorNumberOfPatient: doctor['patientcount'],
                              doctorPicture: doctor['picture'],
                              doctorRating: doctor['rating'],
                              doctorSpecialty: doctor['speciality'],
                              doctorYearOfExperience: doctor['yearofexperience'],
                              doctorWorkingHour: doctor['workinghour'],
                            ),
                          );
                        },
                        child: Cards(
                          doctor: topDoctors[index],
                        ),
                      );
                    },
                  ));
            }));
  }
}
