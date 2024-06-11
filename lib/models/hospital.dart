class Hospital {
  final int id;
  final String name;
  final String address;
  final String lattitude;
  final String longitude;

  Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.lattitude,
    required this.longitude,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      lattitude: json['lattitude'],
      longitude: json['longitude'],
    );
  }
}
