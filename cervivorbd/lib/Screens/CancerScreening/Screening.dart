import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';


class Screening extends StatefulWidget {
  const Screening({Key? key}) : super(key: key);

  @override
  State<Screening> createState() => _ScreeningState();
}

class _ScreeningState extends State<Screening> {
  final List<GroupButtonController> _radioController =
      List.filled(33, GroupButtonController());
  final List<TextEditingController> _textController =
      List.filled(33, TextEditingController());

  final List<String> questions = [
    'বয়স *',
    'যৌনসঙ্গীর সংখ্যা',
    'প্রথম যৌন মিলনের বয়স',
    'গর্ভধারণের সংখ্যা',
    'আপনি কি ধূমপান করেন?',
    'আপনি কত বছর ধরে ধূমপান করছেন?',
    'আপনি বছরে কত প্যাকেট সিগারেট খান?',
    'আপনি কি জন্মনিরোধক হরমোন গ্রহণ করেন?',
    'আপনি কত বছর ধরে জন্মনিরোধক হরমোন ব্যবহার করেছেন?',
    'আপনি কি ইন্ট্রা উটেরিন ডিভাইস (আই ইউ ডি) ব্যবহার করেছেন?',
    'আপনি কত বছর ধরে ইন্ট্রা উটেরিন ডিভাইস (আই ইউ ডি) ব্যবহার করেছেন?',
    'আপনার কি পূর্বে যৌনবাহিত রোগ (এসটিডি) নির্ণীত হয়েছে?',
    'আপনার পূর্বে কতগুলো যৌনবাহিত রোগ (এসটিডি) নির্ণীত হয়েছে?',
    'আপনার পূর্বে মোট কতবার যৌনবাহিত রোগ (এসটিডি) নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এইডস নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এইচআইভি নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে হেপাটাইটিস বি নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এইচপিভি নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এসটিডি (কোনডাইলোমেটোসিস) নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এসটিডি (সার্ভিকাল কোনডাইলোমেটোসিস) নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এসটিডি (ভ্যাজাইনাল কোনডাইলোমেটোসিস) নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এসটিডি (ভলভো - পেরিনিয়াল কোনডাইলোমেটোসিস) নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে এসটিডি (সিফিলিস) নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে শ্রোণী প্রদাহজনক রোগ নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে জেনিটাল হারপিস নির্ণীত হয়েছে?',
    'আপনার কি পূর্বে মলাস্কাম কন্টাজিওসাম নির্ণীত হয়েছে?',
    'রোগ নির্ণয়ের পরে ক্যান্সারের উপস্থিতি?',
    'রোগ নির্ণয়ের পরে সার্ভিকাল ইন্ট্রাপিথেলিয়াল নিউওপ্লাসিয়া এর উপস্থিতি?',
    'রোগ নির্ণয়ের পরে এইচপিভি এর উপস্থিতি?',
    'রোগ নির্ণয়ের পরে এইচপিভি/সার্ভিকাল ইন্ট্রাপিথেলিয়াল নিউওপ্লাসিয়া/ক্যান্সারের এর উপস্থিতি?',
    'কলপোস্কোপির(হিন্সেলম্যান) ফলাফল পজিটিভ হলে ১ চাপুন, অন্যথায় ০ চাপুন',
    'শিলার আয়োডিন পরীক্ষার ফলাফল পজিটিভ হলে ১ চাপুন, অন্যথায় ০ চাপুন',
    'প্যাপ স্মিয়ার পরীক্ষার ফলাফল পজিটিভ হলে ১ চাপুন, অন্যথায় ০ চাপুন',
  ];

  final List<List<String>> _radioButtons = [
    //5
    [
      'হ্যাঁ',
      'না',
    ],
    [
      '০',
      '১',
    ],
  ];

  @override
  void initState() {
    for (var i = 0; i < _radioController.length; i++) {
      _radioController[i] = GroupButtonController(
        selectedIndexes: [],
        // disabledIndexes: [2, 3],
        // onDisablePressed: (index) => ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('${_radioButtons[index]} is disabled')),
        // ),
      );
    }
    for (var i = 0; i < _textController.length; i++) {
      _textController[i] = TextEditingController();
    }
    super.initState();
  }

  void printSelected() {
    print('-------------------------');
    for (var i = 0; i < _radioController.length; i++) {
      print(_radioController[i].selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Heading(label: "সার্ভিকাল ক্যান্সার স্ক্রিনিং"),
            TextFormField2(controller: _textController[0], label: questions[0]),
            TextFormField2(controller: _textController[1], label: questions[1]),
            TextFormField2(controller: _textController[2], label: questions[2]),
            TextFormField2(controller: _textController[3], label: questions[3]),
            TestRadio(
                question: questions[4],
                radioButtons: _radioButtons[0],
                radioController: _radioController[0],
                type: true),
            TextFormField2(controller: _textController[4], label: questions[5]),
            TextFormField2(controller: _textController[5], label: questions[6]),
            TestRadio(
                question: questions[7],
                radioButtons: _radioButtons[0],
                radioController: _radioController[1],
                type: true),
            TextFormField2(controller: _textController[6], label: questions[8]),
            TestRadio(
                question: questions[9],
                radioButtons: _radioButtons[0],
                radioController: _radioController[2],
                type: true),
            TextFormField2(
                controller: _textController[7], label: questions[10]),
            TestRadio(
                question: questions[11],
                radioButtons: _radioButtons[0],
                radioController: _radioController[3],
                type: true),
            TextFormField2(
                controller: _textController[8], label: questions[12]),
            TextFormField2(
                controller: _textController[9], label: questions[13]),
            TestRadio(
                question: questions[14],
                radioButtons: _radioButtons[0],
                radioController: _radioController[4],
                type: true),
            TestRadio(
                question: questions[15],
                radioButtons: _radioButtons[0],
                radioController: _radioController[5],
                type: true),
            TestRadio(
                question: questions[16],
                radioButtons: _radioButtons[0],
                radioController: _radioController[6],
                type: true),
            TestRadio(
                question: questions[17],
                radioButtons: _radioButtons[0],
                radioController: _radioController[7],
                type: true),
            TestRadio(
                question: questions[18],
                radioButtons: _radioButtons[0],
                radioController: _radioController[8],
                type: true),
            TestRadio(
                question: questions[19],
                radioButtons: _radioButtons[0],
                radioController: _radioController[9],
                type: true),
            TestRadio(
                question: questions[20],
                radioButtons: _radioButtons[0],
                radioController: _radioController[10],
                type: true),
            TestRadio(
                question: questions[21],
                radioButtons: _radioButtons[0],
                radioController: _radioController[11],
                type: true),
            TestRadio(
                question: questions[22],
                radioButtons: _radioButtons[0],
                radioController: _radioController[12],
                type: true),
            TestRadio(
                question: questions[23],
                radioButtons: _radioButtons[0],
                radioController: _radioController[13],
                type: true),
            TestRadio(
                question: questions[24],
                radioButtons: _radioButtons[0],
                radioController: _radioController[14],
                type: true),
            TestRadio(
                question: questions[25],
                radioButtons: _radioButtons[0],
                radioController: _radioController[15],
                type: true),
            TestRadio(
                question: questions[26],
                radioButtons: _radioButtons[0],
                radioController: _radioController[16],
                type: true),
            TestRadio(
                question: questions[27],
                radioButtons: _radioButtons[0],
                radioController: _radioController[17],
                type: true),
            TestRadio(
                question: questions[28],
                radioButtons: _radioButtons[0],
                radioController: _radioController[18],
                type: true),
            TestRadio(
                question: questions[29],
                radioButtons: _radioButtons[0],
                radioController: _radioController[19],
                type: true),
            TestRadio(
                question: questions[30],
                radioButtons: _radioButtons[1],
                radioController: _radioController[20],
                type: true),
            TestRadio(
                question: questions[31],
                radioButtons: _radioButtons[1],
                radioController: _radioController[21],
                type: true),
            TestRadio(
                question: questions[32],
                radioButtons: _radioButtons[1],
                radioController: _radioController[22],
                type: true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton2(
                  onPressed: () {
                    printSelected();
                  },
                  label: 'Submit'),
            )
          ],
        ),
      ),
    );
  }
}
