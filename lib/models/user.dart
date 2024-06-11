import 'patient.dart'; // Sesuaikan dengan path model PatientModel

class UserModel {
  int id;
  String username;
  String role;
  String accessToken;
  Patient? patient;

  UserModel({
    required this.id,
    required this.username,
    required this.role,
    required this.accessToken,
    this.patient,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      role: json['role'],
      accessToken: json['access_token'],
      patient:
          json['patient'] != null ? Patient.fromJson(json['patient']) : null,
    );
  }

  factory UserModel.fromBasic({
    required int id,
    required String accessToken,
  }) {
    return UserModel(
      id: id,
      username: '',
      role: '',
      accessToken: accessToken,
    );
  }
}
