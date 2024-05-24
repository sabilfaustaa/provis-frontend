import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digisehat/providers/doctor_provider.dart';
import 'package:digisehat/models/doctor.dart';
import 'package:digisehat/models/review.dart';

class DetailDokterPage extends StatefulWidget {
  final int doctorId;

  DetailDokterPage({required this.doctorId});

  @override
  _DetailDokterPageState createState() => _DetailDokterPageState();
}

class _DetailDokterPageState extends State<DetailDokterPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false)
        .fetchDoctor(widget.doctorId);
    Provider.of<DoctorProvider>(context, listen: false)
        .fetchReviews(widget.doctorId);
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors("");
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final doctor = doctorProvider.doctor;
    final reviews = doctorProvider.reviews;
    final otherDoctors = doctorProvider.doctors;

    return Scaffold(
      body: doctor == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
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
                HeaderCard(doctor: doctor),
                DraggableScrollableSheet(
                  initialChildSize: 0.72,
                  minChildSize: 0.72,
                  maxChildSize: 0.95,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: darkPrimaryColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
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
                                      'Pendidikan dan Pengalaman',
                                      style: TextStyle(
                                        color: lightColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      doctor.experience,
                                      style: TextStyle(
                                        color: lightColor.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Filosofi Perawatan',
                                      style: TextStyle(
                                        color: lightColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      doctor.philosophy,
                                      style: TextStyle(
                                        color: lightColor.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Inovasi dan Penelitian',
                                      style: TextStyle(
                                        color: lightColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      doctor.innovation,
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
                            ReviewPasien(reviews: reviews),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Divider(color: lightColor),
                            ),
                            DokterSuggestion(doctors: otherDoctors),
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
  final Doctor doctor;

  HeaderCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: inputColor,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      elevation: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage('assets/hanif.png'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, right: 12.0, bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    doctor.name,
                    style: lightTextStyle.copyWith(
                        fontSize: 20, fontWeight: bolder),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doctor.specialty,
                    style: secondaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '70 Tahun ++',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColor,
                                fontSize: 10),
                          ),
                          Text(
                            'Pengalaman',
                            style: TextStyle(
                                color: lightColor,
                                fontSize: 15,
                                fontWeight: light),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '5000 ++',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColor,
                                fontSize: 10),
                          ),
                          Text(
                            'Pasien',
                            style: TextStyle(
                                color: lightColor,
                                fontSize: 15,
                                fontWeight: light),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.bookmark_border,
                          size: 14,
                          color: lightColor,
                        ),
                        label: Text('Simpan',
                            style: lightTextStyle.copyWith(fontSize: 12)),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          backgroundColor: orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.share, size: 14, color: lightColor),
                        label: Text('Bagikan',
                            style: lightTextStyle.copyWith(fontSize: 12)),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          backgroundColor: orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
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
  final List<Review> reviews;

  ReviewPasien({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              var review = reviews[index];
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
                        review.name,
                        style: TextStyle(
                          color: lightColor,
                        ),
                      ),
                      Wrap(
                        spacing: 4,
                        children: List<Widget>.generate(
                          5,
                          (int starIndex) => Icon(
                            starIndex < review.rating
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
                        review.time,
                        style: TextStyle(
                          color: lightColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        review.review,
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
  final List<Doctor> doctors;

  DokterSuggestion({required this.doctors});

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
              itemCount: doctors.length,
              itemBuilder: (BuildContext context, int index) {
                var dokter = doctors[index];
                return Container(
                  width: 320,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                    color: inputColor,
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        Image.network(
                          "assets/hanif.png",
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
                                Text(dokter.name,
                                    style: lightTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                Text(
                                  dokter.specialty,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: lightColor,
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      starIndex < 4
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 20,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                Text(
                                  '12 reviews',
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
