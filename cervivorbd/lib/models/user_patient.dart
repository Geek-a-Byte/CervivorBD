class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? phonenumber;

  UserModel({this.uid, this.fullname, this.email, this.phonenumber});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      fullname: map['fullname'],
      email: map['email'],
      phonenumber: map['phonenumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'phonenumber': phonenumber,
    };
  }
}
