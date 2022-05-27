import 'package:cervivorbd/models/doctor.dart';
import 'package:cervivorbd/widgets/top_doctor_card.dart';
import 'package:flutter/material.dart';

class TopDoctorsList extends StatelessWidget {
  const TopDoctorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:SizedBox(
        height: h*0.37,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: topDoctors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/doctor_details',
                  arguments: Doctor(
                    doctorName: topDoctors[index].doctorName,
                    doctorDescription: topDoctors[index].doctorDescription,
                    doctorHospital: topDoctors[index].doctorHospital,
                    doctorIsOpen: topDoctors[index].doctorIsOpen,
                    doctorNumberOfPatient:topDoctors[index].doctorNumberOfPatient,
                    doctorPicture: topDoctors[index].doctorPicture,
                    doctorRating: topDoctors[index].doctorRating,
                    doctorSpecialty: topDoctors[index].doctorSpecialty,
                    doctorYearOfExperience: topDoctors[index].doctorYearOfExperience,
                    doctorWorkingHour: topDoctors[index].doctorWorkingHour,
                ));
              },
              child: Cards(
                doctor: topDoctors[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
