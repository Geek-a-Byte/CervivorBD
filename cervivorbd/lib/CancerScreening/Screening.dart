import 'package:cervivorbd/models/question.dart';
import 'package:cervivorbd/widgets/question_widget.dart';
import 'package:flutter/material.dart';

class ScreeningPage extends StatefulWidget {
  @override
  _ScreeningPageState createState() => _ScreeningPageState();
}

class _ScreeningPageState extends State<ScreeningPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: questions2.length,
            itemBuilder: (context, index) {
              return QuestionWidget(questions2[index]);
            }));
  }
}
