import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:digisehat/navigation_bar.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatKonsultasiPage extends StatefulWidget {
  const RiwayatKonsultasiPage({super.key});

  @override
  State<RiwayatKonsultasiPage> createState() => _RiwayatKonsultasiPageState();
}

class _RiwayatKonsultasiPageState extends State<RiwayatKonsultasiPage> {
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
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Histori Konsultasi',
                        style: lightTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: _consultationHistory,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var consultation = snapshot.data![index];
                            return ListTile(
                              title: Text('Reservation Number: ${consultation['reservation_num']}'),
                              subtitle: Text('Time: ${consultation['time']} - Location: ${consultation['location']}'),
                              onTap: () {
                                // Handle tap
                              },
                            );
                          },
                        );
                      } else {
                        return Center(child: Text("No data found"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: alertColor,
        child: Icon(Icons.warning),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0,
        onItemSelected: (index) {
          // Handle item select
        },
      ),
    );
  }
}


class TransactionCard extends StatelessWidget {
  final dynamic consultation; // Tambahkan field untuk data konsultasi

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
              'assets/doctor_image.png', // Ganti dengan URL gambar dokter atau simbolik jika tidak ada
              height: 150,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Dr. Ahmad Hanif', // Ganti dengan nama dokter dari data
                    style: lightTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Dokter Gigi', // Ganti dengan spesialisasi dokter dari data
                    style: lightTextStyle.copyWith(fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    consultation['location'], // Tampilkan lokasi konsultasi dari data
                    style: lightTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Waktu: ${consultation['time']}', // Tampilkan waktu konsultasi
                    style: lightTextStyle.copyWith(fontSize: 12),
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

