import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digisehat/navigation_bar.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';

class RiwayatKonsultasiPage extends StatefulWidget {
  const RiwayatKonsultasiPage({super.key});

  @override
  State<RiwayatKonsultasiPage> createState() => _RiwayatKonsultasiPageState();
}

class _RiwayatKonsultasiPageState extends State<RiwayatKonsultasiPage> {
  int _selectedIndex = 0;
  late Future<List<dynamic>> _consultationHistory;

  @override
  void initState() {
    super.initState();
    _consultationHistory = fetchConsultationHistory();
  }

  Future<List<dynamic>> fetchConsultationHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    int? userId = prefs.getInt('user_id');

    if (token == null || userId == null) {
      throw Exception('User not logged in or session expired');
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/schedule_patient/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load consultation history');
    }
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                        'Histori Konsultasi',
                        style: lightTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari riwayat konsultasi....',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: khakiColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: alertColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.search, color: lightColor),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<dynamic>>(
                    future: _consultationHistory,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var consultation = snapshot.data![index];
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () {
                                  redirectTo(context, "/diagnosa-pasien");
                                },
                                child: TransactionCard(consultation: consultation),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text("No consultation history found"));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: alertColor,
            elevation: 2.0,
            shape: CircleBorder(),
            child: Icon(Icons.warning, size: 28),
          ),
          SizedBox(height: 4),
          Text(
            'Gawat Darurat',
            style: lightTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          _selectTab(index);
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final dynamic consultation;

  const TransactionCard({super.key, required this.consultation});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            ),
            child: Image.network(
              'assets/ijay.png', // Ganti dengan URL gambar Anda.
              height: 150,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dokter ID: ${consultation['doctor_id']}', // Use dynamic data
                  style: lightTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   'Dr. Ahmad Hanif', 
                //   style: lightTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                // ),
                // Text(
                //   'Dokter Kandungan', 
                //   style: lightTextStyle.copyWith(fontWeight: medium),
                // ),
                SizedBox(height: 4.0),
                Text(
                  'Berkonsultasi dengan dokter hanif terkait myiopia yang dialami minggu kemarin',
                  style: lightTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  'Reservasi: ${consultation['reservation_num']}', // Use dynamic data
                  style: lightTextStyle.copyWith(fontWeight: medium),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Waktu: ${consultation['time']}', // Use dynamic data
                  style: lightTextStyle.copyWith(fontSize: 12),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Lokasi: ${consultation['location']}', // Use dynamic data
                  style: lightTextStyle.copyWith(fontSize: 12),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    // buildButton(context, "Lihat Detail", () {}, orangeColor,
                    //  
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
