class Question {
  String question;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  int type;
  String ans;
  Question(this.question, this.optionA, this.optionB, this.optionC,
      this.optionD, this.ans, this.type);
}

class Question2 {
  final String question;
  final List<Option> options;
  final int type;

  Question2({
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

final List<Question> questions = [
  Question(
      "'OS' computer abbreviation usually means ?",
      "Order of Significance",
      "Open Software",
      "Operating System",
      "Optical Sensor",
      "Operating System",
      1),
  Question(
      "'.MOV' extension refers usually to what kind of file?",
      "Image file",
      "Animation/movie file",
      "Audio file",
      "MS Office document",
      "Animation/movie file",
      2),
  Question(
      "Who developed Yahoo?",
      "Dennis Ritchie & Ken Thompson",
      "David Filo & Jerry Yang",
      "Vint Cerf & Robert Kahn",
      "Steve Case & Jeff Bezos",
      "Dennis Ritchie & Ken Thompson",
      2),
  Question("What does AM mean?", "Angelo marconi", "Anno median",
      "Amplitude modulation", "Amperes", "Amplitude modulation", 1),
  Question(
      "Where is the headquarters of Intel located?",
      "Redmond, Washington",
      "Tucson, Arizona",
      "Santa Clara, California",
      "Richmond, Virginia",
      "Santa Clara, California",
      1)
];

final questions2 = [
  Question2(
    question: 'Which planet is the hottest in the solar system?',
    options: [
      const Option(code: 'A', text: 'Earth', isCorrect: false),
      const Option(code: 'B', text: 'Venus', isCorrect: true),
      const Option(code: 'C', text: 'Jupiter', isCorrect: false),
      const Option(code: 'D', text: 'Saturn', isCorrect: false),
    ],
    type: 1,
  ),
    Question2(
    question: 'Which planet is the hottest in the solar system?',
    options: [
      const Option(code: 'A', text: 'Earth', isCorrect: false),
      const Option(code: 'B', text: 'Venus', isCorrect: true),
      const Option(code: 'C', text: 'Jupiter', isCorrect: false),
    ],
    type: 2,
  ),
];
