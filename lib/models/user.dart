class UserModel {
  final String nama;
  final String nik;
  final String jenisKelamin;
  final String alamat;
  final String noTelepon;
  final String tanggalLahir;
  final String penyakitAlergi;
  final String tahun;
  final String username;
  final int id;

  UserModel({
    required this.nama,
    required this.nik,
    required this.jenisKelamin,
    required this.alamat,
    required this.noTelepon,
    required this.tanggalLahir,
    required this.penyakitAlergi,
    required this.tahun,
    required this.username,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nama: json['Nama'],
      nik: json['NIK'],
      jenisKelamin: json['Jenis Kelamin'],
      alamat: json['Alamat'],
      noTelepon: json['No. Telepon'],
      tanggalLahir: json['Tanggal Lahir'],
      penyakitAlergi: json['Penyakit / Alergi'],
      tahun: json['Tahun'],
      username: json['username'],
      id: json['id'],
    );
  }
}
