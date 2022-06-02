// ignore_for_file: avoid_print

import 'package:cervivorbd/widgets/test_check_box.dart';
import 'package:cervivorbd/widgets/test_radio.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../widgets/elevated_button.dart';

class Screening extends StatefulWidget {
  const Screening({Key? key}) : super(key: key);

  @override
  State<Screening> createState() => _ScreeningState();
}

class _ScreeningState extends State<Screening> {
  final List<GroupButtonController> _checkboxesController =
      List.filled(1, GroupButtonController());
  final List<GroupButtonController> _radioController =
      List.filled(5, GroupButtonController());

  final List<String> questions = [
    'সন্তানের সংখ্যা *',
    'বয়স *',
    'বিবাহের সংখ্যা *',
    'পারিবারিক সদস্যের মধ্যে কারো জরায়ুর ক্যান্সার হয়েছে?',
    'জর্দা অথবা পান খাওয়ার অভ্যাস আছে?',
    'নিম্নলিখিত কোন কোন লক্ষণ পূর্বে দেখা দিয়েছে?',
  ];
  final List<List<String>> _checkboxButtons = [
    [
      'অনিয়মিত মাসিক চক্র',
      'যোগাযোগে রক্তপাত (যেমন যৌন মিলনের সময়)',
      'স্ট্রেইনিংয়ে রক্তপাত (মলত্যাগের সময়)',
      'অতিরিক্ত সাদা স্রাব যা দুর্গন্ধযুক্ত স্রাব',
    ]
  ];

  final List<List<String>> _radioButtons = [
    [
      '০',
      '১',
      '২',
      '৩',
      '৪ অথবা তার উপরে',
    ],
    [
      '২৫-৩৫ বছর',
      '৩৫-৪৫ বছর',
      '৪৫-৬৫ বছর',
    ],
    ['১', 'একের অধিক'],
    [
      'হ্যাঁ',
      'না',
    ],
    [
      'হ্যাঁ',
      'না',
    ],
  ];

  @override
  void initState() {
    for (var i = 0; i < _checkboxesController.length; i++) {
      _checkboxesController[i] = GroupButtonController(
        selectedIndexes: [],
        // disabledIndexes: [0],
        // onDisablePressed: (index) => ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(content: Text('${_checkboxButtons[i][index]} is disabled')),
        // ),
      );
    }
     for (var i = 0; i < _radioController.length; i++) {
       _radioController[i] = GroupButtonController(
        selectedIndexes: [],
        // disabledIndexes: [2, 3],
        // onDisablePressed: (index) => ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('${_radioButtons[index]} is disabled')),
        // ),
      );
    }
    super.initState();
  }

  void printSelected() {
    for (var i = 0; i < _checkboxesController.length; i++) {
      print(_checkboxesController[i].selectedIndexes);
    }
    print('-------------------------');
    for (var i = 0; i < _radioController.length; i++) {
      print(_radioController[i].selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
         
          TestRadio(
              question: questions[0],
              radioButtons: _radioButtons[0],
              radioController: _radioController[0],
              type: true),
          TestRadio(
              question: questions[1],
              radioButtons: _radioButtons[1],
              radioController: _radioController[1],
              type: true),
          TestRadio(
              question: questions[2],
              radioButtons: _radioButtons[2],
              radioController: _radioController[2],
              type: true),
           TestRadio(
              question: questions[4],
              radioButtons: _radioButtons[4],
              radioController: _radioController[4],
              type: true),
          TestRadio(
              question: questions[3],
              radioButtons: _radioButtons[3],
              radioController: _radioController[3],
              type: true),
          TestCheckBox(
              question: questions[5],
              checkboxButtons: _checkboxButtons[0],
              checkboxesController: _checkboxesController[0],
              type: false),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton2(
                onPressed: () {
                  printSelected();
                },
               label:'Submit'),
          )
        ],
      ),
    );
  }
}
