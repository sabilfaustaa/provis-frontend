import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
// import 'package:digisehat/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:digisehat/component.dart';

class PanduanObatPage extends StatefulWidget {
  @override
  _PanduanObatPageState createState() => _PanduanObatPageState();
}

class _PanduanObatPageState extends State<PanduanObatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.arrow_back, color: Colors.white),
                backgroundColor: Colors.blue,
                mini: true,
              ),
            ),
          ),
          HeaderCard(),
          DraggableScrollableSheet(
            initialChildSize: 0.72,
            minChildSize: 0.72,
            maxChildSize: 0.95,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: darkPrimaryColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Center(
                        child: Container(
                          width: 100,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tentang Dokter',
                                style: TextStyle(
                                  color: lightColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Pendidikan dan Pengalaman : Dr. Ahmad Hanif adalah seorang dokter mata yang berpengalaman dan berkualifikasi tinggi. Dia lulus dengan predikat cum laude dari salah satu universitas terkemuka di negaranya dan kemudian menyelesaikan residensi serta fellowship dalam bidang oftalmologi di rumah sakit terkemuka di dalam dan luar negeri. Selama karirnya, Dr. Hanif telah bekerja dengan berbagai kasus yang berkaitan dengan mata, mulai dari masalah refraksi hingga prosedur bedah kompleks.',
                                style: TextStyle(
                                  color: lightColor.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Divider(color: lightColor),
                            ],
                          )),
                      JadwalDokter(),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(color: lightColor),
                      ),
                      JadwalDokterSelector(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(color: lightColor),
                      ),
                      ReviewPasien(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(color: lightColor),
                      ),
                      DokterSuggestion(),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: FloatingActionButton.extended(
                onPressed: () {
                  redirectTo(context, "/jadwal-konsultasi");
                },
                label: Text(
                  'Konsultasi Sekarang',
                  style: lightTextStyle.copyWith(fontWeight: bold),
                ),
                icon: Icon(Icons.chat, color: lightColor),
                backgroundColor: orangeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(gradientHomeBoxDecoration),
          Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 130.0,
                            height: 130.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('assets/ijay.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Ahmad Defrizal',
                              style: lightTextStyle.copyWith(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 4,
                          ),
                          Text('18 Tahun | 180 cm | 75 Kg',
                              style: lightTextStyle),
                        ],
                      ),
                    ),
                    _buildInfoCard(
                        'Informasi Kontak Pengguna',
                        [
                          'No KTP',
                          'NIK',
                          'Nama Lengkap',
                          'Tanggal Lahir',
                          'Jenis Kelamin',
                          'Alamat Lengkap',
                          'Nomor Telepon',
                        ],
                        priceColor),
                    _buildInfoCard(
                        'Informasi Kesehatan Pengguna',
                        [
                          'BMI',
                          'Tinggi Badan',
                          'Berat Badan',
                          'Riwayat Penyakit',
                        ],
                        priceColor),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: lightColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text('Profil Saya',
                  style: TextStyle(color: lightColor, fontSize: 20)),
            ],
          ),
          IconButton(
            icon: Icon(Icons.edit, color: lightColor),
            onPressed: () {
              redirectTo(context, '/profile-edit');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      String title, List<String> items, Color backgroundColor) {
    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ExpansionTile(
        backgroundColor: primaryColor,
        title: Text(
          title,
          style: lightTextStyle,
        ),
        children: items
            .map((item) => ListTile(
                    title: Text(
                  item,
                  style: lightTextStyle,
                )))
            .toList(),
      ),
    );
  }
}

class JadwalDokter extends StatefulWidget {
  @override
  _JadwalDokterState createState() => _JadwalDokterState();
}

class _JadwalDokterState extends State<JadwalDokter> {
  String? _selectedYear = '2023';
  String? _selectedMonth = 'Maret';
  List<String> years = ['2021', '2022', '2023', '2024', '2025'];
  List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Jadwal Dokter',
                style: TextStyle(
                  color: lightColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: <Widget>[
                  DropdownButton<String>(
                    value: _selectedYear,
                    items: years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: lightColor)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedYear = newValue;
                      });
                    },
                    underline: Container(height: 0),
                    dropdownColor: priceColor,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  DropdownButton<String>(
                    value: _selectedMonth,
                    items: months.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: lightColor)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMonth = newValue;
                      });
                    },
                    underline: Container(height: 0),
                    dropdownColor: priceColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 31,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 70,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: inputColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Senin',
                      style: TextStyle(color: lightColor, fontSize: 16),
                    ),
                    Text(
                      '${index + 1}',
                      style: TextStyle(
                          color: lightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class JadwalDokterSelector extends StatefulWidget {
  @override
  _JadwalDokterSelectorState createState() => _JadwalDokterSelectorState();
}

class _JadwalDokterSelectorState extends State<JadwalDokterSelector> {
  int _selectedScheduleIndex = -1;

  List<String> schedules = [
    '08.30 - 09.00 WIB',
    '09.00 - 09.30 WIB',
    '09.30 - 10.00 WIB',
    '10.00 - 10.30 WIB',
    '10.30 - 11.00 WIB',
    '11.00 - 11.30 WIB',
    '16.30 - 17.00 WIB',
    '17.00 - 17.30 WIB',
    '17.30 - 18.00 WIB',
  ];

  Widget scheduleButton(int index) {
    bool isSelected = _selectedScheduleIndex == index;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        avatar: isSelected
            ? Icon(Icons.check, color: inputColor)
            : Icon(Icons.access_time, color: lightColor),
        label: Text(
          schedules[index],
          style: TextStyle(
            color: isSelected ? Colors.black : lightColor,
          ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            _selectedScheduleIndex = selected ? index : -1;
          });
        },
        selectedColor: secondaryColor,
        backgroundColor: inputColor,
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jadwal Dokter',
            style: TextStyle(
                color: lightColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Wrap(
            children: List<Widget>.generate(
                schedules.length, (index) => scheduleButton(index)),
          ),
        ],
      ),
    );
  }
}

class ReviewPasien extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Sarah Wijaya',
      'time': '2 hari lalu',
      'review':
          'Dr. Hanif sangat sabar dan teliti dalam menjelaskan kondisi mata saya. Saya merasa sangat dipahami dan yakin dengan perawatan yang direkomendasikannya.',
      'rating': 4.0,
    },
    {
      'name': 'Budi Santoso',
      'time': '8 hari lalu',
      'review':
          'Pelayanan dari Dr. Hanif sangat baik, namun saya berharap waktu tunggu bisa lebih singkat. Tetapi secara keseluruhan, saya puas dengan kualitas perawatannya.',
      'rating': 4.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Review Pasien',
                style: TextStyle(
                  color: lightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    '4.3 Review Pasien',
                    style: TextStyle(
                      color: lightColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: inputColor,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/dummy-human.png'),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        reviews[index]['name'],
                        style: TextStyle(
                          color: lightColor,
                        ),
                      ),
                      Wrap(
                        spacing: 4,
                        children: List<Widget>.generate(
                          5,
                          (int starIndex) => Icon(
                            starIndex < reviews[index]['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        reviews[index]['time'],
                        style: TextStyle(
                          color: lightColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        reviews[index]['review'],
                        style: TextStyle(color: lightColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lainnya ->',
                  style: TextStyle(color: lightColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DokterSuggestion extends StatelessWidget {
  final List<Map<String, dynamic>> dokters = [
    {
      'name': 'Dr. Ahmad Sabil',
      'speciality': 'Dokter THT',
      'experience': '27 Tahun',
      'rating': 5,
      'reviews': 325,
      'image': 'assets/ijay.png',
    },
    {
      'name': 'Dr. Ahmad Taufik',
      'speciality': 'Dokter Kandungan',
      'experience': '12 Tahun',
      'rating': 4,
      'reviews': 152,
      'image': 'assets/hanif.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Lihat Dokter Lainnya',
              style: TextStyle(
                  color: lightColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dokters.length,
              itemBuilder: (BuildContext context, int index) {
                var dokter = dokters[index];
                return Container(
                  width: 320,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                    color: inputColor,
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        Image.asset(
                          dokter['image'],
                          fit: BoxFit.cover,
                          width: 120,
                          height: 180,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(dokter['name'],
                                    style: lightTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                Text(
                                  dokter['speciality'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: lightColor,
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      starIndex < dokter['rating']
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 20,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${dokter['reviews']} reviews',
                                  style: lightTextStyle.copyWith(
                                    fontSize: 14,
                                    color: lightColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    size: 14,
                                    color: lightColor,
                                  ),
                                  label: Text('Lihat Dokter',
                                      style: lightTextStyle.copyWith(
                                          fontSize: 12)),
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 10.0),
                                    backgroundColor: darkPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
