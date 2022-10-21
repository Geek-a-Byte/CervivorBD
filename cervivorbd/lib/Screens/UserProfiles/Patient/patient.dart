class Patient {
  String? uid;
  String? fullname;
  String? email;
  String? phonenumber;

  Patient({this.uid, this.fullname, this.email, this.phonenumber});

  //   Patient.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   //  phone = json['phone'];
  //   address = json['address'];
  //   isStuff = json['isStuff'] == null ? false : json['isStuff'] as bool;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['address'] = this.address;
  //   data['name'] = this.name;
  //   //   data['phone'] = this.phone;

  //   data['isStuff'] = this.isStuff;
  //   return data;
  // }

  // receiving data from server

  factory Patient.fromMap(map) {
    return Patient(
      // userType: map['userType'],
      uid: map['uid'],
      fullname: map['fullname'],
      email: map['email'],
      phonenumber: map['phonenumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      // 'userType': "Patient",
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'phonenumber': phonenumber,
    };
  }
}
