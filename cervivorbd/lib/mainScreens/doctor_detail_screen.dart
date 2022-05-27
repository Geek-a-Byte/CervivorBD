import 'package:cervivorbd/models/doctor.dart';
import 'package:flutter/material.dart';


class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Doctor;
    return Container();
  }
}
