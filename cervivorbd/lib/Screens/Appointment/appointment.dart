class Appointment {
  String? name;
  String? phone;
  String? description;
  String? doctor;
  DateTime? date;

  Appointment({
    this.name,
    this.phone,
    this.description,
    this.doctor,
    this.date,
  });

  //posting data to server
  factory Appointment.fromMap(map) {
    return Appointment(
      name: map['name'],
      phone: map['phone'],
      description: map['description'],
      doctor: map['doctor'],
      date: map['date'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMapAppointment() {
    return {
      'name': name,
      'phone': phone,
      'description': description,
      'doctor': doctor,
      'date': date,
    };
  }
}
