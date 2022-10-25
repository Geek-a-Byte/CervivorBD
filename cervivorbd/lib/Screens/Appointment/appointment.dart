class Appointment {
  String? patient;
  String? patientUID;
  String? doctorUID;
  String? phone;
  String? description;
  String? doctor;
  DateTime? date;
  bool? approvalStatus;
  Appointment({
    this.approvalStatus,
    this.doctorUID,
    this.patientUID,
    this.patient,
    this.phone,
    this.description,
    this.doctor,
    this.date,
  });

  //posting data to server
  factory Appointment.fromMap(map) {
    return Appointment(
      approvalStatus:map['approvalStatus'],
      doctorUID: map['doctorUID'],
      patientUID: map['patientUID'],
      patient: map['patient'],
      phone: map['phone'],
      description: map['description'],
      doctor: map['doctor'],
      date: map['date'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMapAppointment() {
    return {
      'approvalStatus':approvalStatus,
      'doctorUID': doctorUID,
      'patientUID': patientUID,
      'patient': patient,
      'phone': phone,
      'description': description,
      'doctor': doctor,
      'date': date,
    };
  }
}
