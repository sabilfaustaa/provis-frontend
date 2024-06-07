class PatientModel {
  int id;
  String name;
  int userId;
  String nik;
  String gender;
  String address;
  String telephone;
  String dateOfBirth;
  String medicalRecord;
  String allergy;
  bool bpjsStatus;

  PatientModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.nik,
    required this.gender,
    required this.address,
    required this.telephone,
    required this.dateOfBirth,
    required this.medicalRecord,
    required this.allergy,
    required this.bpjsStatus,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      nik: json['nik'],
      gender: json['gender'],
      address: json['address'],
      telephone: json['telephone'],
      dateOfBirth: json['date_of_birth'],
      medicalRecord: json['medical_record'],
      allergy: json['allergy'],
      bpjsStatus: json['bpjs_status'],
    );
  }
}
