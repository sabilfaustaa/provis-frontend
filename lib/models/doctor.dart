class Doctor {
  final int id;
  final String name;
  final String specialty;
  final String hospital;
  final String experience;
  final String philosophy;
  final String innovation;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.experience,
    required this.philosophy,
    required this.innovation,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      hospital: json['hospital'],
      experience: json['experience'],
      philosophy: json['philosophy'],
      innovation: json['innovation'],
    );
  }
}
