import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';

class DiagnosaPasienPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(gradientHomeBoxDecoration),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                        'Diagnosa Pasien',
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
                          'Ahmad Defrizal',
                          style: TextStyle(
                            color: lightColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '18 Tahun | 180 cm | 75 Kg',
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
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: primaryColor, // Color for the title bar
                                padding: EdgeInsets.all(
                                  16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.medical_information_outlined,
                                        color: Colors.white),
                                    SizedBox(width: 8.0),
                                    Text('Dokter',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              DokterCard(),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        InputDiagnosaPasien(),
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
}

class DokterCard extends StatelessWidget {
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
              height: 210,
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
                    'Dr. Ahmad Hanif',
                    style: lightTextStyle.copyWith(
                        fontSize: 20, fontWeight: bolder),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Dokter Mata',
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
                          Icons.remove_red_eye,
                          size: 14,
                          color: lightColor,
                        ),
                        label: Text('Lihat Dokter',
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
          ),
        ],
      ),
    );
  }
}

class InputDiagnosaPasien extends StatefulWidget {
  @override
  _InputDiagnosaPasienState createState() => _InputDiagnosaPasienState();
}

class _InputDiagnosaPasienState extends State<InputDiagnosaPasien> {
  // State variables to hold the text input
  String gejalaUmum = '';
  String gejalaKhusus = '';
  String gejalaTambahan = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: primaryColor,
      child: ExpansionTile(
        leading: Icon(Icons.health_and_safety, color: lightColor),
        title: Container(
          color: primaryColor,
          child: Text('Gejala Pasien', style: TextStyle(color: lightColor)),
        ),
        children: <Widget>[
          Container(
            color: inputColor,
            child: Column(
              children: [
                ListTile(
                  title:
                      Text('Gejala Umum', style: TextStyle(color: lightColor)),
                  subtitle: TextField(
                    style: TextStyle(color: lightColor), // Warna teks input
                    decoration: InputDecoration(
                      hintText: 'Mata merah, nyeri mata, penglihatan kabur',
                      hintStyle: TextStyle(
                          color:
                              lightColor.withOpacity(0.7)), // Warna placeholder
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                lightColor), // Warna garis bawah saat tidak aktif
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: lightColor), // Warna garis bawah saat fokus
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        gejalaUmum = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Gejala Khusus',
                      style: TextStyle(color: lightColor)),
                  subtitle: TextField(
                    style: TextStyle(color: lightColor), // Warna teks input
                    decoration: InputDecoration(
                      hintText:
                          'Sensasi terbakar, perasaan berpasir di mata, kelopak mata bengkak',
                      hintStyle: TextStyle(
                          color:
                              lightColor.withOpacity(0.7)), // Warna placeholder
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                lightColor), // Warna garis bawah saat tidak aktif
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: lightColor), // Warna garis bawah saat fokus
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        gejalaKhusus = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Gejala Tambahan',
                      style: TextStyle(color: lightColor)),
                  subtitle: TextField(
                    style: TextStyle(color: lightColor), // Warna teks input
                    decoration: InputDecoration(
                      hintText:
                          'Pengeluaran lendir atau nanah, fotofobia (sensitivitas terhadap cahaya)',
                      hintStyle: TextStyle(
                          color:
                              lightColor.withOpacity(0.7)), // Warna placeholder
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                lightColor), // Warna garis bawah saat tidak aktif
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: lightColor), // Warna garis bawah saat fokus
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        gejalaTambahan = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
