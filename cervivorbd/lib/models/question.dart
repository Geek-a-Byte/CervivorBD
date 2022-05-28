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

const List<Map<String, Object>> questions2 = [
  {
    "questionText": "Who is the best cricketer in the world?",
    'answers': [
      {'text': 'Sachin Tendukar', 'score': 0},
      {'text': 'Virat Kohli', 'score': 0},
      {'text': 'Sandeep Lamichhane', 'score': 10},
    ],
    'type': 1,
  },
  {
    "questionText": "What is the Full form of RAM?",
    'answers': [
      {'optionA': 'Random Access Memory', 'score': 10},
      {'text': 'Ram Ate Memory', 'score': 0},
      {'text': 'Read Any Memory', 'score': 0},
      
    ],
    'type': 1,
  },
  {
    "questionText": "What's capital city of USA?",
    'answers': [
      {'text': 'London', 'score': 0},
      {'text': 'New York', 'score': 0},
      {'text': 'Tokyo', 'score': 0},
      {'text': 'Washington, D.C.', 'score': 10},
    ],
    'type': 1,
  }
];
