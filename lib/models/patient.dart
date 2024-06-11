class Patient {
  final String name;
  final int userId;
  final String medicalRecord;
  final String nik;
  final String gender;
  final String address;
  final String telephone;
  final String dateOfBirth;
  final String allergy;
  final String allergyYear;
  final bool bpjsStatus;
  final int height; // New field
  final int weight; // New field
  final double bmi; // New field
  final int age; // New field

  Patient({
    required this.name,
    required this.userId,
    required this.medicalRecord,
    required this.nik,
    required this.gender,
    required this.address,
    required this.telephone,
    required this.dateOfBirth,
    required this.allergy,
    required this.allergyYear,
    required this.bpjsStatus,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.age,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      userId: json['user_id'],
      medicalRecord: json['medical_record'],
      nik: json['nik'],
      gender: json['gender'],
      address: json['address'],
      telephone: json['telephone'],
      dateOfBirth: json['date_of_birth'],
      allergy: json['allergy'],
      allergyYear: json['allergy_year'],
      bpjsStatus: json['bpjs_status'],
      height: json['height'], // New field
      weight: json['weight'], // New field
      bmi: json['bmi'], // New field
      age: json['age'], // New field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'user_id': userId,
      'medical_record': medicalRecord,
      'nik': nik,
      'gender': gender,
      'address': address,
      'telephone': telephone,
      'date_of_birth': dateOfBirth,
      'allergy': allergy,
      'allergy_year': allergyYear,
      'bpjs_status': bpjsStatus,
      'height': height,
      'weight': weight,
      'bmi': bmi,
      'age': age,
    };
  }
}
