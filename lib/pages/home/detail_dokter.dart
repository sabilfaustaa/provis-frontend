import 'package:digisehat/providers/auth_provider.dart';
import 'package:digisehat/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digisehat/providers/doctor_provider.dart';
import 'package:digisehat/models/doctor.dart';
import 'package:digisehat/models/review.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DetailDokterPage extends StatefulWidget {
  final int doctorId;

  DetailDokterPage({required this.doctorId});

  @override
  _DetailDokterPageState createState() => _DetailDokterPageState();
}

class _DetailDokterPageState extends State<DetailDokterPage> {
  DateTime? _selectedDate;
  String? _selectedTime;
  List<String> times = [
    '08:30 - 09:00',
    '09:00 - 09:30',
    '09:30 - 10:00',
    '10:00 - 10:30',
    '10:30 - 11:00',
    '11:00 - 11:30',
    '16:30 - 17:00',
    '17:00 - 17:30',
    '17:30 - 18:00',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            colorScheme: ColorScheme.light(primary: primaryColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String generateReservationNum() {
    var rng = Random();
    return rng.nextInt(999999).toString().padLeft(6, '0');
  }

  void _createSchedule() async {
    if (_selectedDate != null && _selectedTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      bool success = await Provider.of<DoctorProvider>(context, listen: false)
          .createSchedule(
              Provider.of<DoctorProvider>(context, listen: false).doctor!.id,
              formattedDate,
              _selectedTime!,
              Provider.of<DoctorProvider>(context, listen: false)
                  .doctor!
                  .hospital,
              authProvider.user!.id,
              generateReservationNum());
      if (success) {
        Navigator.pushNamed(context, '/jadwal-konsultasi');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuat jadwal konsultasi')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pilih tanggal dan waktu terlebih dahulu')),
      );
    }
  }

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
                            JadwalDokterSelector(
                              selectedDate: _selectedDate,
                              selectedTime: _selectedTime,
                              onDateSelected: () => _selectDate(context),
                              onTimeSelected: (time) {
                                setState(() {
                                  _selectedTime = time;
                                });
                              },
                              times: times,
                            ),
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
                      onPressed: _createSchedule,
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

class JadwalDokterSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTime;
  final Function onDateSelected;
  final Function(String) onTimeSelected;
  final List<String> times;

  JadwalDokterSelector({
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateSelected,
    required this.onTimeSelected,
    required this.times,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Tanggal dan Waktu',
            style: TextStyle(
                color: lightColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ElevatedButton.icon(
            icon: Icon(Icons.calendar_today),
            label: Text(selectedDate == null
                ? 'Pilih Tanggal'
                : DateFormat('dd-MM-yyyy').format(selectedDate!)),
            onPressed: () => onDateSelected(),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: List<Widget>.generate(
              times.length,
              (index) => ChoiceChip(
                label: Text(
                  times[index],
                  style: TextStyle(
                    color: selectedTime == times[index]
                        ? Colors.black
                        : lightColor,
                  ),
                ),
                selected: selectedTime == times[index],
                onSelected: (selected) => onTimeSelected(times[index]),
                selectedColor: secondaryColor,
                backgroundColor: inputColor,
              ),
            ),
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
