import 'package:cervivorbd/models/question.dart';
import 'package:cervivorbd/widgets/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AppEnum { optionA, optionB, optionC, optionD, NON }

// ignore: must_be_immutable
class QuestionWidget extends StatefulWidget {
  Question question;
  QuestionWidget(
    this.question, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _QuestionWidgetState createState() => _QuestionWidgetState(question);
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Question item;
  _QuestionWidgetState(this.item);

  AppEnum _character = AppEnum.NON;

  bool _isSelectedA = false;
  bool _isSelectedB = false;
  bool _isSelectedC = false;
  bool _isSelectedD = false;

  int radio = 1;
  int check = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          item.type == check ? getCheckBoxWidget(item) : getRadioWidget(item),
          const SizedBox(
            height: 30.0,
          ),
          actionButton(),
        ]));
  }

  onVerifyClick() {
    var msg = "";

    if (item.type == radio) {
      if (_character == AppEnum.optionA && item.optionA == item.ans ||
          _character == AppEnum.optionB && item.optionB == item.ans ||
          _character == AppEnum.optionC && item.optionC == item.ans ||
          _character == AppEnum.optionD && item.optionD == item.ans) {
        msg = "Correct";
      } else {
        msg = "Incorrect";
      }
    } else {
      if (_isSelectedA && item.optionA == item.ans ||
          _isSelectedB && item.optionB == item.ans ||
          _isSelectedC && item.optionC == item.ans ||
          _isSelectedD && item.optionD == item.ans) {
        msg = "Correct";
      } else {
        msg = "Incorrect";
      }
    }

    print(msg);
    Fluttertoast.showToast(msg: msg);
  }

  Widget getRadioWidget(Question item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item.question,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          Column(
            children: [

              RadioListTile<AppEnum>(
                dense: true,
                title: Text(item.optionA),
                value: AppEnum.optionA,
                groupValue: _character,
                onChanged: (AppEnum? value) {
                  setState(() {
                    _character = value!;
                  });
                },
              ),
              RadioListTile<AppEnum>(
                dense: true,
                title: Text(item.optionB),
                value: AppEnum.optionB,
                groupValue: _character,
                onChanged: (AppEnum? value) {
                  setState(() {
                    _character = value!;
                  });
                },
              ),
              RadioListTile<AppEnum>(
                dense: true,
                title: Text(item.optionC),
                value: AppEnum.optionC,
                groupValue: _character,
                onChanged: (AppEnum? value) {
                  setState(() {
                    _character = value!;
                  });
                },
              ),
              RadioListTile<AppEnum>(
                dense: true,
                title: Text(item.optionD),
                value: AppEnum.optionD,
                groupValue: _character,
                onChanged: (AppEnum? value) {
                  setState(() {
                    _character = value!;
                  });
                },
              ),
            ],
          ),
        ]);
  }

  Widget getCheckBoxWidget(Question item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item.question,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          CheckBoxWidget(
            label: item.optionA,
            value: _isSelectedA,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedA = newValue;
              });
            },
          ),
          CheckBoxWidget(
            label: item.optionB,
            value: _isSelectedB,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedB = newValue;
              });
            },
          ),
          CheckBoxWidget(
            label: item.optionC,
            value: _isSelectedC,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedC = newValue;
              });
            },
          ),
          CheckBoxWidget(
            label: item.optionD,
            value: _isSelectedD,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedD = newValue;
              });
            },
          ),
        ]);
  }

  Widget actionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          color: const Color(0xFF167F67),
          child: const Text(
            "Verify",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => onVerifyClick(),
        ),
        const SizedBox(
          width: 20.0,
        ),
        // RaisedButton(
        //   color: const Color(0xFF167F67),
        //   child: const Text(
        //     "Next",
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   onPressed: () => onNextClick(),
        // ),
      ],
    );
  }

  // onNextClick() {
  //   buttonCarouselController.nextPage(
  //       duration: const Duration(milliseconds: 300), curve: Curves.linear);
  // }
}
