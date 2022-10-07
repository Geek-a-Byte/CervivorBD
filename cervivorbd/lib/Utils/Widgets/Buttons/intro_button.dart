// ignore_for_file: use_key_in_widget_constructors

import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';


var introMenu = [
  IntroButton2(label: 'জরায়ুর ক্যান্সার কি?', onPressed: () {}),
  IntroButton2(label: 'জরায়ুর ক্যান্সারের কারণ', onPressed: () {}),
  IntroButton2(label: 'জরায়ুর ক্যান্সারের লক্ষণ', onPressed: () {}),
  IntroButton2(
      label: 'জরায়ুর ক্যান্সারের রোগনির্ণয় পদ্ধতি', onPressed: () {}),
  IntroButton2(label: 'জরায়ুর ক্যান্সারের চিকিৎসা', onPressed: () {}),
  IntroButton2(
      label: 'চিকিৎসার ঝুঁকি এবং পার্শ্ব প্রতিক্রিয়া', onPressed: () {}),
  IntroButton2(label: 'পোস্ট অপারেটিভ কেয়ার', onPressed: () {}),
  IntroButton2(label: 'জরায়ুর ক্যান্সার প্রতিরোধ', onPressed: () {}),
  IntroButton2(label: 'সার্ভিকাল ক্যান্সার স্ক্রিনিং', onPressed: () {}),
];

var introPhotoMenu = [
  'assets/images/question.png',
  'assets/images/causes.png',
  'assets/images/symptoms.png',
  'assets/images/diagnosis.png',
  'assets/images/treatment.png',
  'assets/images/side-effect.png',
  'assets/images/post-operative-care.png',
  'assets/images/prevention.png',
  'assets/images/Screening.png',
];

var introPageNavigationMenu = [
  const WhatisCervicalCancer(),
  const WhatisCervicalCancer(),
  const WhatisCervicalCancer(),
  const WhatisCervicalCancer(),
  const WhatisCervicalCancer(),
  const WhatisCervicalCancer(),
  const WhatisCervicalCancer(),
  const WhatisCervicalCancer(),
  const Screening(),
];
var optionMenu = [
  IntroButton2(label: 'অনসাইট ভিসিট (১০০ টাকা)', onPressed: () {}),
  IntroButton2(label: 'চ্যাট/ভিডিও কল (৫০ টাকা)', onPressed: () {}),
];

var centerMenu = [
  IntroButton3(label: 'ঢাকা', onPressed: () {}),
  IntroButton3(label: 'চট্টগ্রাম', onPressed: () {}),
  IntroButton3(label: 'সিলেট', onPressed: () {}),
  IntroButton3(label: 'বরিশাল', onPressed: () {}),
  IntroButton3(label: 'খুলনা', onPressed: () {}),
  IntroButton3(label: 'রংপুর', onPressed: () {}),
  IntroButton3(label: 'রাজশাহী', onPressed: () {}),
];

class IntroButton2 extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;

  const IntroButton2({@required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            primary: const Color.fromARGB(255, 245, 155, 202),
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: .5),
            side: const BorderSide(width: 1.0, color: Colors.pink)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: Text(
              label!,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}

class IntroButton3 extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;

  const IntroButton3({@required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(224, 0, 0, 0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.red)))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(.5),
            child: Text(
              label!,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
