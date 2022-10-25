import 'dart:ffi';

class AppointmentBookedHours {
  Array? busyTime;
  AppointmentBookedHours({
    this.busyTime,
  });

  //posting data to server
  factory AppointmentBookedHours.fromMap(map) {
    return AppointmentBookedHours(busyTime: map['busyTime']);
  }

  // sending data to our server
  Map<String, dynamic> toMapAppointmentBookedHours() {
    return {
      'busyTime': busyTime,
    };
  }
}
