import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';
import 'package:digisehat/providers/konsultasi_provider.dart';
import 'package:digisehat/models/consultation_schedule.dart';

class JadwalKonsultasiPage extends StatefulWidget {
  final int scheduleId;

  JadwalKonsultasiPage({required this.scheduleId});

  @override
  _JadwalKonsultasiPageState createState() => _JadwalKonsultasiPageState();
}

class _JadwalKonsultasiPageState extends State<JadwalKonsultasiPage> {
  Future<ConsultationSchedule?>? _futureSchedule;

  @override
  void initState() {
    super.initState();
    final konsultasiProvider =
        Provider.of<KonsultasiProvider>(context, listen: false);
    _futureSchedule =
        konsultasiProvider.fetchConsultationScheduleById(widget.scheduleId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConsultationSchedule?>(
      future: _futureSchedule,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          final schedule = snapshot.data!;
          return Scaffold(
            body: Stack(
              children: [
                buildBackground(gradientHomeBoxDecoration),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: lightColor),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Text(
                              'Jadwal Konsultasi',
                              style: lightTextStyle.copyWith(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[600],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      'assets/ijay.png',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                schedule.patient?.patient?.name ?? 'No name',
                                style: TextStyle(
                                  color: lightColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${schedule.patient?.patient?.dateOfBirth ?? 'N/A'} Tahun | ${schedule.patient?.patient?.dateOfBirth ?? 'N/A'} cm | ${schedule.patient?.patient?.dateOfBirth ?? 'N/A'} Kg',
                                style: TextStyle(
                                  color: lightColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(16.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.assignment_turned_in,
                                              color: Colors.white),
                                          SizedBox(width: 8.0),
                                          Text('Nomor Antrian',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: inputColor,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          schedule.reservationNum ?? 'N/A',
                                          style: TextStyle(
                                              fontSize: 58,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(
                                        16.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.access_time,
                                              color: Colors.white),
                                          SizedBox(width: 8.0),
                                          Text('Waktu dan Tempat',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: inputColor,
                                      padding: EdgeInsets.all(32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            schedule.timeStart +
                                                '-' +
                                                schedule.timeEnd,
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            schedule.location ?? 'N/A',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(
                                        16.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                              Icons
                                                  .medical_information_outlined,
                                              color: Colors.white),
                                          SizedBox(width: 8.0),
                                          Text('Dokter',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 240,
                                      decoration: BoxDecoration(
                                        color: inputColor,
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage('assets/ijay.png'),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.center,
                                                colors: [
                                                  Colors.black12
                                                      .withOpacity(0.8),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 16,
                                            bottom: 16,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  schedule.doctor?.name ??
                                                      'N/A',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  children:
                                                      List.generate(5, (index) {
                                                    return Icon(
                                                      index < 4
                                                          ? Icons.star
                                                          : Icons.star_border,
                                                      color: Colors.amber,
                                                      size: 20,
                                                    );
                                                  }),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  '${schedule.doctor?.experience ?? 'N/A'} tahun ++ Pengalaman',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  '${schedule.doctor?.name ?? 'N/A'} orang Pasien',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(
                                        16.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.qr_code,
                                              color: Colors.white),
                                          SizedBox(width: 8.0),
                                          Text('Barcode',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      width: double.infinity,
                                      height: 240,
                                      decoration: BoxDecoration(
                                        color: inputColor,
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image:
                                              AssetImage('assets/barcode.png'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(
                                        16.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.chat_rounded,
                                              color: Colors.white),
                                          SizedBox(width: 8.0),
                                          Text('Konsultasikan Sekarang',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      width: double.infinity,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: inputColor,
                                      ),
                                      child: buildButton(context,
                                          "Mulai chat dengan ${schedule.doctor?.name}",
                                          () {
                                        redirectTo(context, "/pesan");
                                      }, orangeColor, lightColor),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
