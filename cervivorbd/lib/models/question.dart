class Question{
  final String question;
  final List<Option> options;
  final int type;

  Question({
    required this.question,
    required this.options,
    required this.type,
  });
}

class Option {
  final String code;
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.code,
    required this.isCorrect,
  });
}

final questions = [
  Question(
    question: 'সন্তানের সংখ্যা *',
    options: [
      const Option(code: 'A', text: '০', isCorrect: false),
      const Option(code: 'B', text: '১', isCorrect: true),
      const Option(code: 'C', text: '২', isCorrect: false),
      const Option(code: 'D', text: '৩', isCorrect: false),
      const Option(code: 'E', text: '৪ অথবা তার উপরে', isCorrect: false),
    ],
    type: 1,
  ),
   Question(
    question: 'বয়স *',
    options: [
      const Option(code: 'A', text: '২৫-৩৫ বছর', isCorrect: false),
      const Option(code: 'B', text: '৩৫-৪৫ বছর', isCorrect: true),
      const Option(code: 'C', text: '৪৫-৬৫ বছর', isCorrect: true),
    ],
    type: 1,
  ),
  Question(
    question: 'বিবাহের সংখ্যা *',
    options: [
      const Option(code: 'A', text: '১', isCorrect: false),
      const Option(code: 'B', text: 'একের অধিক', isCorrect: true),
    ],
    type: 1,
  ),
  Question(
    question: 'পারিবারিক সদস্যের মধ্যে কারো জরায়ুর ক্যান্সার হয়েছে?',
    options: [
      const Option(code: 'A', text: 'হ্যাঁ', isCorrect: false),
      const Option(code: 'B', text: 'না', isCorrect: true),
    ],
    type: 1,
  ),
  Question(
    question: 'জর্দা অথবা পান খাওয়ার অভ্যাস আছে?',
    options: [
      const Option(code: 'A', text: 'হ্যাঁ', isCorrect: false),
      const Option(code: 'B', text: 'না', isCorrect: true),
    ],
    type: 1,
  ),
  Question(
    question: 'নিম্নলিখিত কোন কোন লক্ষণ পূর্বে দেখা দিয়েছে?',
    options: [
      const Option(code: 'A', text: 'অনিয়মিত মাসিক চক্র', isCorrect: false),
      const Option(code: 'B', text: 'যোগাযোগে রক্তপাত (যেমন যৌন মিলনের সময়)', isCorrect: true),
      const Option(code: 'B', text: 'স্ট্রেইনিংয়ে রক্তপাত (মলত্যাগের সময়)', isCorrect: true),
      const Option(code: 'B', text: 'অতিরিক্ত সাদা স্রাব যা দুর্গন্ধযুক্ত স্রাব', isCorrect: true),
    ],
    type: 2,
  ),
];
