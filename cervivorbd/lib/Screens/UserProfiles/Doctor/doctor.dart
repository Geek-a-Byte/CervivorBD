//doctor

class Doctor {
  String? userType;
  String? uid;
  String? fullname;
  String? email;
  String? phonenumber;
  String? doctorPicture;
  String? doctorDescription;
  String? doctorHospital;
  String? doctorSpeciality;
  String? doctorStartWorkingHour;
  String? doctorEndWorkingHour;
  String? doctorYearOfExperience;
  bool? doctorIsOpen;

  Doctor(
      {this.userType,
      this.uid,
      this.fullname,
      this.doctorPicture,
      this.email,
      this.phonenumber,
      this.doctorDescription,
      this.doctorHospital,
      this.doctorSpeciality,
      this.doctorStartWorkingHour,
      this.doctorEndWorkingHour,
      this.doctorYearOfExperience,
      this.doctorIsOpen});

  Doctor.fromMap(Map<String, dynamic> json) {
    userType = json['userType'];
    uid = json["uid"];
    fullname = json['doctorName'];
    doctorPicture = json['doctorPicture'];
    email = json['doctorEmail'];
    phonenumber = json['doctorPhone'];
    doctorDescription = json['doctorDescription'];
    doctorHospital = json['doctorHospital'];
    doctorSpeciality = json['doctorSpeciality'];
    doctorStartWorkingHour = json['doctorStartWorkingHour'];
    doctorEndWorkingHour = json['doctorEndWorkingHour'];
    doctorYearOfExperience = json['doctorYearOfExperience'];
    doctorIsOpen = json['doctorIsOpen'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userType'] = "Doctor";
    data['uid'] = uid;
    data['fullname'] = fullname;
    data['doctorPicture'] = doctorPicture;
    data['email'] = email;
    data['phonenumber'] = phonenumber;
    data['doctorDescription'] = doctorDescription;
    data['doctorHospital'] = doctorHospital;
    data['doctorSpeciality'] = doctorSpeciality;
    data['doctorStartWorkingHour'] = doctorStartWorkingHour;
    data['doctorEndWorkingHour'] = doctorEndWorkingHour;
    data['doctorYearOfExperience'] = doctorYearOfExperience;
    data['doctorIsOpen'] = doctorIsOpen;
    return data;
  }
}

var topDoctors = [
  Doctor(
      doctorStartWorkingHour: 'Mon - Fri, 9.00 AM-20.00 PM',
      fullname: 'Nazia Shehnaz Joynab',
      doctorSpeciality: 'Oncologist',
      doctorHospital: 'GDN Hospital',
      doctorYearOfExperience: '4',
      doctorDescription:
          'She is one of the best doctors in the GDN Hospital. He has saved more than 800 patients in the past 4 years. She has also received many awards from domestic and abroad as the best doctors. She is available on a private or schedule.',
      doctorPicture: 'img-women-03.png',
      doctorIsOpen: true),
  Doctor(
      doctorStartWorkingHour: 'Mon - Fri, 9.00 AM-20.00 PM',
      fullname: 'Sazia Tabasum Mim',
      doctorSpeciality: 'Oncologist',
      doctorHospital: 'ABC Carolus Hospital',
      doctorYearOfExperience: '6',
      doctorDescription:
          'She is one of the best doctors in the ABC Carolus Hospital. She has saved more than 1400 patients in the past 6 years. She has also received many awards from domestic and abroad as the best doctors. She is available on a private or schedule.',
      doctorPicture: 'img-women-02.png',
      doctorIsOpen: false),
  Doctor(
      fullname: 'Fairooz Nawar Nawme',
      doctorSpeciality: 'Oncologist',
      doctorHospital: 'XYZ Asia Hospital',
      doctorYearOfExperience: '4',
      doctorDescription:
          'is one of the best doctors in the Columbia Asia Hospital. He has saved more than 900 patients in the past 4 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
      doctorPicture: 'img-women-01.png',
      doctorStartWorkingHour: 'Mon - Fri, 9.00 AM-20.00 PM',
      doctorIsOpen: false),
];
