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
                          Navigator.pop(context);
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
                                color: primaryColor,
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
                        InputDaftarDiagnosaPasien(),
                        InputDaftarObat(),
                        InputRekomendasiTindakan(),
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
  String gejalaUmum = '';
  String gejalaKhusus = '';
  String gejalaTambahan = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: primaryColor,
      child: ExpansionTile(
        initiallyExpanded: true,
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
                    style: TextStyle(color: lightColor),
                    decoration: InputDecoration(
                      hintText: 'Mata merah, nyeri mata, penglihatan kabur',
                      hintStyle: TextStyle(color: lightColor.withOpacity(0.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
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
                    style: TextStyle(color: lightColor),
                    decoration: InputDecoration(
                      hintText:
                          'Sensasi terbakar, perasaan berpasir di mata, kelopak mata bengkak',
                      hintStyle: TextStyle(color: lightColor.withOpacity(0.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
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
                    style: TextStyle(color: lightColor),
                    decoration: InputDecoration(
                      hintText:
                          'Pengeluaran lendir atau nanah, fotofobia (sensitivitas terhadap cahaya)',
                      hintStyle: TextStyle(color: lightColor.withOpacity(0.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
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

class InputDaftarDiagnosaPasien extends StatefulWidget {
  @override
  _InputDaftarDiagnosaPasienState createState() =>
      _InputDaftarDiagnosaPasienState();
}

class _InputDaftarDiagnosaPasienState extends State<InputDaftarDiagnosaPasien> {
  String penjelasan = '';
  String penyebab = '';
  String gejalaTambahan = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: primaryColor,
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(Icons.health_and_safety, color: lightColor),
        title: Container(
          color: primaryColor,
          child: Text('Daftar Diagnosa', style: TextStyle(color: lightColor)),
        ),
        children: <Widget>[
          Container(
            color: inputColor,
            child: Column(
              children: [
                ListTile(
                  title:
                      Text('Penjelasan', style: TextStyle(color: lightColor)),
                  subtitle: TextField(
                    style: TextStyle(color: lightColor),
                    decoration: InputDecoration(
                      hintText:
                          'Ketidakmampuan membersihkan sekret atau obstruksi jalan nafas untuk mempertahankan jalan nafas tetap paten.',
                      hintStyle: TextStyle(color: lightColor.withOpacity(0.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        penjelasan = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Penyebab', style: TextStyle(color: lightColor)),
                  subtitle: TextField(
                    style: TextStyle(color: lightColor),
                    decoration: InputDecoration(
                      hintText:
                          'Spasme jalan napas, Hipersekresi jalan napas, Disfungsi neuromuskuler.',
                      hintStyle: TextStyle(color: lightColor.withOpacity(0.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        penyebab = value;
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

class InputDaftarObat extends StatefulWidget {
  @override
  _InputDaftarObatState createState() => _InputDaftarObatState();
}

class _InputDaftarObatState extends State<InputDaftarObat> {
  String antibiotik = '';
  String antiinflamasi = '';
  String pelembabMata = '';
  String analgesik = '';
  String vitaminMineral = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: primaryColor,
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(Icons.list, color: lightColor),
        title: Text('Daftar Obat', style: TextStyle(color: lightColor)),
        children: <Widget>[
          Container(
              color: inputColor,
              child: Column(children: [
                _buildListItem(
                    'Antibiotik',
                    'Tetes mata antibiotik, salep antibiotik',
                    antibiotik,
                    (value) => setState(() => antibiotik = value)),
                _buildListItem(
                    'Antiinflamasi',
                    'Tetes mata antiinflamasi, steroid mata',
                    antiinflamasi,
                    (value) => setState(() => antiinflamasi = value)),
                _buildListItem(
                    'Pelembab Mata',
                    'Tetes mata pelembab, salep pelembab',
                    pelembabMata,
                    (value) => setState(() => pelembabMata = value)),
                _buildListItem(
                    'Analgesik',
                    'Obat penghilang nyeri, kompres mata hangat',
                    analgesik,
                    (value) => setState(() => analgesik = value)),
                _buildListItem(
                    'Vitamin dan Mineral',
                    'Suplemen vitamin A, omega-3',
                    vitaminMineral,
                    (value) => setState(() => vitaminMineral = value)),
              ]))
        ],
      ),
    );
  }

  Widget _buildListItem(
      String title, String hintText, String value, Function(String) onChanged) {
    return ListTile(
      title: Text(title, style: TextStyle(color: lightColor)),
      subtitle: TextField(
        controller: TextEditingController(text: value),
        style: TextStyle(color: lightColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: lightColor.withOpacity(0.7)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightColor),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class InputRekomendasiTindakan extends StatefulWidget {
  @override
  _InputRekomendasiTindakanState createState() =>
      _InputRekomendasiTindakanState();
}

class _InputRekomendasiTindakanState extends State<InputRekomendasiTindakan> {
  String pengobatan = '';
  String terapi = '';
  String pencegahan = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: primaryColor,
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(Icons.list, color: lightColor),
        title:
            Text('Rekomendasi Tindakan', style: TextStyle(color: lightColor)),
        children: <Widget>[
          Container(
              color: inputColor,
              child: Column(children: [
                _buildListItem(
                    'Pengobatan',
                    'Penggunaan obat sesuai resep dokter',
                    pengobatan,
                    (value) => setState(() => pengobatan = value)),
                _buildListItem('Terapi', 'Terapi fisik, terapi kacamata',
                    terapi, (value) => setState(() => terapi = value)),
                _buildListItem(
                    'Pencegahan',
                    'Menjaga kebersihan mata, menghindari penggunaan lensa kontak yang lama',
                    pencegahan,
                    (value) => setState(() => pencegahan = value)),
              ]))
        ],
      ),
    );
  }

  Widget _buildListItem(
      String title, String hintText, String value, Function(String) onChanged) {
    return ListTile(
      title: Text(title, style: TextStyle(color: lightColor)),
      subtitle: TextField(
        controller: TextEditingController(text: value),
        style: TextStyle(color: lightColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: lightColor.withOpacity(0.7)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightColor),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
