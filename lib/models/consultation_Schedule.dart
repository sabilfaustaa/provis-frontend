import 'package:digisehat/models/doctor.dart';
import 'package:digisehat/models/user.dart';

class ConsultationSchedule {
  final int id;
  final int doctorId;
  final String date;
  final String time;
  final String location;
  final int patientId;
  final String reservationNum;
  final UserModel patient;
  final Doctor doctor;

  ConsultationSchedule({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.time,
    required this.location,
    required this.patientId,
    required this.reservationNum,
    required this.patient,
    required this.doctor,
  });

  factory ConsultationSchedule.fromJson(Map<String, dynamic> json) {
    return ConsultationSchedule(
      id: json['id'],
      doctorId: json['doctor_id'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      patientId: json['patient_id'],
      reservationNum: json['reservation_num'],
      patient: UserModel.fromJson(json['patient']),
      doctor: Doctor.fromJson(json['doctor']),
    );
  }
}
