class Doctor {
  Doctor(
      {this.doctorName = '',
      this.doctorSpecialty = '',
      this.doctorRating = '',
      this.doctorHospital = '',
      this.doctorNumberOfPatient = '',
      this.doctorYearOfExperience = '',
      this.doctorDescription = '',
      this.doctorPicture = '',
      this.doctorIsOpen = false});
  String doctorName;
  String doctorSpecialty;
  String doctorRating;
  String doctorHospital;
  String doctorNumberOfPatient;
  String doctorYearOfExperience;
  String doctorDescription;
  String doctorPicture;
  bool doctorIsOpen;
}

var topDoctors = [
  Doctor(
    doctorName: 'Sazia Tabasum Mim',
    doctorSpecialty: 'Oncologist',
    doctorRating: '4.7',
    doctorHospital: 'XYZ Asia Hospital',
    doctorNumberOfPatient: '964',
    doctorYearOfExperience: '4',
    doctorDescription:
        'is one of the best doctors in the Columbia Asia Hospital. He has saved more than 900 patients in the past 4 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
    doctorPicture: 'img-women-01.png',
    doctorIsOpen: false
  ),
  Doctor(
    doctorName: 'Nawme Nawar',
    doctorSpecialty: 'Oncologist',
    doctorRating: '4.8',
    doctorHospital: 'ABC Carolus Hospital',
    doctorNumberOfPatient: '1451',
    doctorYearOfExperience: '6',
    doctorDescription:
        'is one of the best doctors in the Salemba Carolus Hospital. He has saved more than 1400 patients in the past 6 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
    doctorPicture: 'img-women-02.png',
    doctorIsOpen: false
  ),
  Doctor(
    doctorName: 'Nazia Shehnaz Joynab',
    doctorSpecialty: 'Oncologist',
    doctorRating: '4.7',
    doctorHospital: 'GDN Hospital',
    doctorNumberOfPatient: '888',
    doctorYearOfExperience: '4',
    doctorDescription:
        'is one of the best doctors in the Wiloso Hospital. He has saved more than 800 patients in the past 4 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
    doctorPicture: 'img-women-03.png',
    doctorIsOpen: true
  ),
];
