class UserModel {
  final int id;
  final String username;
  final String name;
  final String medicalRecord;
  final String nik;
  final String gender;
  final String address;
  final String telephone;
  final String dateOfBirth;
  final String allergy;
  final String allergyYear;
  final String accessToken;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.medicalRecord,
    required this.nik,
    required this.gender,
    required this.address,
    required this.telephone,
    required this.dateOfBirth,
    required this.allergy,
    required this.allergyYear,
    required this.accessToken,
  });

  UserModel.fromBasic({
    required this.id,
    required this.accessToken,
  })  : username = '',
        name = '',
        medicalRecord = '',
        nik = '',
        gender = '',
        address = '',
        telephone = '',
        dateOfBirth = '',
        allergy = '',
        allergyYear = '';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      medicalRecord: json['medical_record'],
      nik: json['nik'],
      gender: json['gender'],
      address: json['address'],
      telephone: json['telephone'],
      dateOfBirth: json['date_of_birth'],
      allergy: json['allergy'],
      allergyYear: json['allergy_year'],
      accessToken: json['access_token'],
    );
  }
}
