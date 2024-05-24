import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digisehat/navigation_bar.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';


class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage({super.key});

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  late Future<List<dynamic>> _transactionHistory;

  @override
  void initState() {
    super.initState();
    _transactionHistory = fetchTransactionHistory();
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

  Future<double> fetchMedicinePrice(int medicineId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('User not logged in or session expired');
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/medicine/$medicineId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return double.parse(data['price'].toString());  // 'price' adalah bagian dari respons
    } else {
      throw Exception('Failed to load medicine price');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(gradientHomeBoxDecoration),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text('Riwayat Transaksi', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                FutureBuilder<List<dynamic>>(
                  future: _transactionHistory,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return TransactionCard(transaction: snapshot.data![index]);
                        },
                      );
                    } else {
                      return Center(child: Text("No transactions found"));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0,
        onItemSelected: (index) {},
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
              'assets/dummy-artikel.png', // Replace with actual image URL.
              height: 130,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  transaction['payment'],
                  style: lightTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${transaction['price']}',
                  style: lightTextStyle.copyWith(fontWeight: FontWeight.normal),
                ),
                Text(
                  transaction['courier'],
                  style: lightTextStyle,
                ),
                Text(
                  'Delivered to: ${transaction['address']}',
                  style: lightTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
