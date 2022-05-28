import 'package:cervivorbd/models/question.dart';
import 'package:cervivorbd/widgets/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var clicked = [0, 1, 2, 3, 4];

// ignore: must_be_immutable
class QuestionWidget extends StatefulWidget {
  Question2 question;
  QuestionWidget(
    this.question, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _QuestionWidgetState createState() => _QuestionWidgetState(question);
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Question2 item;
  _QuestionWidgetState(this.item);

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

  int char = 0;
  Widget buildOption(BuildContext context, Option option, int index) {
    return RadioListTile<int>(
      dense: true,
      title: Text(option.text),
      value: clicked[index],
      groupValue: char,
      onChanged: (value) {
        setState(() {
          char = value!;
        });
      },
    );
  }

  final _isSelected = [false, false, false, false, false];
  Widget buildMultiOption(BuildContext context, Option option, int index) {
    return CheckBoxWidget(
      label: option.text,
      value: _isSelected[index],
      onChanged: (bool newValue) {
        setState(() {
          _isSelected[index] = newValue;
        });
      },
    );
  }

  onVerifyClick() {
    var msg = "";
    print(char);
    if (item.type == radio) {
      if (item.options[char].isCorrect == true) {
        msg = "Correct";
      } else {
        msg = "Incorrect";
      }
      } else {
        if (_isSelected[char]) {
          msg = "Correct";
        } else {
          msg = "Incorrect";
        }
      }

      // print(msg);
      Fluttertoast.showToast(msg: msg);
    }

  Widget getRadioWidget(Question2 item) {
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
              ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item.options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        buildOption(context, item.options[index], index),
                      ],
                    );
                  }),
            ],
          ),
        ]);
  }

  Widget getCheckBoxWidget(Question2 item) {
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
              ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item.options.length,
                  itemBuilder: (context, index) {
                    return buildMultiOption(
                        context, item.options[index], index);
                  }),
            ],
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
      ],
    );
  }
}
