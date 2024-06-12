import 'package:digisehat/pages/home/jadwal_konsultasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digisehat/navigation_bar.dart';
import 'package:digisehat/theme.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  late Future<List<dynamic>> _consultationHistory;
  late Future<List<dynamic>> _transactionHistory;

  @override
  void initState() {
    super.initState();
    _consultationHistory = fetchConsultationHistory();
    _transactionHistory = fetchTransactionHistory();
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

  Future<List<dynamic>> fetchTransactionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    int? userId = prefs.getInt('user_id');

    if (token == null || userId == null) {
      throw Exception('User not logged in or session expired');
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/order_patient/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load transaction history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Riwayat',
              style: lightTextStyle.copyWith(color: lightColor)),
          backgroundColor: darkPrimaryColor,
          bottom: TabBar(
            labelStyle: lightTextStyle,
            tabs: [
              Tab(
                text: 'Konsultasi',
              ),
              Tab(
                text: 'Transaksi',
              ),
            ],
            indicatorColor: lightColor,
          ),
        ),
        body: TabBarView(
          children: [
            _buildConsultationTab(),
            _buildTransactionTab(),
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
            Text('Gawat Darurat', style: lightTextStyle.copyWith(fontSize: 12)),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 2,
          onItemSelected: (index) {
            // Handle tab selection
          },
        ),
      ),
    );
  }

  Widget _buildConsultationTab() {
    return Container(
      color: darkPrimaryColor,
      child: FutureBuilder<List<dynamic>>(
        future: _consultationHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
                child: Text("Data tidak tersedia", style: lightTextStyle));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ConsultationCard(
                  consultation: snapshot.data![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JadwalKonsultasiPage(
                          scheduleId: snapshot.data![index]['id'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
                child: Text("Data tidak tersedia", style: lightTextStyle));
          }
        },
      ),
    );
  }

  Widget _buildTransactionTab() {
    return Container(
      color: darkPrimaryColor,
      child: FutureBuilder<List<dynamic>>(
        future: _transactionHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
                child: Text("Data tidak tersedia", style: lightTextStyle));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return TransactionCard(transaction: snapshot.data![index]);
              },
            );
          } else {
            return Center(
                child: Text("Data tidak tersedia", style: lightTextStyle));
          }
        },
      ),
    );
  }
}

class ConsultationCard extends StatelessWidget {
  final dynamic consultation;
  final VoidCallback onTap;

  const ConsultationCard(
      {super.key, required this.consultation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      consultation['doctor_name'] ?? 'Unknown Doctor',
                      style: lightTextStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tanggal: ${consultation['date'] ?? 'N/A'}',
                      style: lightTextStyle,
                    ),
                    Text(
                      'Waktu: ${consultation['timestart']} - ${consultation['timeend']}',
                      style: lightTextStyle,
                    ),
                    Text(
                      'Lokasi: ${consultation['location'] ?? 'N/A'}',
                      style: lightTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final dynamic transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              child: Image.network(
                transaction['image_url'] ?? 'assets/dummy-artikel.png',
                height: 130,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction['payment'] ?? 'Unknown Payment',
                    style: lightTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rp ${transaction['price'] ?? 'N/A'}',
                    style:
                        lightTextStyle.copyWith(fontWeight: FontWeight.normal),
                  ),
                  Text(
                    transaction['courier'] ?? 'Unknown Courier',
                    style: lightTextStyle,
                  ),
                  Text(
                    'Delivered to: ${transaction['address'] ?? 'N/A'}',
                    style: lightTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
