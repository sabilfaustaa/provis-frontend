import 'package:digisehat/models/doctor.dart';
import 'package:digisehat/models/user.dart';

class ConsultationSchedule {
  final int id;
  final int doctorId;
  final String date; // Nullable
  final String timeStart;
  final String timeEnd;
  final String location;
  final int patientId;
  final String reservationNum;
  final String status;
  final bool bpjs;
  final UserModel? patient; // Nullable
  final Doctor? doctor; // Nullable

  ConsultationSchedule({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.patientId,
    required this.reservationNum,
    required this.status,
    required this.bpjs,
    this.patient,
    this.doctor,
  });

  factory ConsultationSchedule.fromJson(Map<String, dynamic> json) {
    return ConsultationSchedule(
      id: json['id'],
      doctorId: json['doctor_id'],
      date: json['date'],
      timeStart: json['timestart'],
      timeEnd: json['timeend'],
      location: json['location'],
      patientId: json['patient_id'],
      reservationNum:
          json['reservation_num'].toString(), // Ensure it's a String
      status: json['status'],
      bpjs: json['bpjs'],
      patient: json.containsKey('patient')
          ? UserModel.fromJson(json['patient'])
          : null,
      doctor:
          json.containsKey('doctor') ? Doctor.fromJson(json['doctor']) : null,
    );
  }
}
