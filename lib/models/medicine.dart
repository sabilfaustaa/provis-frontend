class Medicine {
  final int id;
  final String name;
  final String manufacturer;
  final String dosage;
  final String description;
  final int price;

  Medicine({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.dosage,
    required this.description,
    required this.price,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      manufacturer: json['manufacturer'],
      dosage: json['dosage'],
      description: json['description'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'dosage': dosage,
      'description': description,
      'price': price,
    };
  }
}
