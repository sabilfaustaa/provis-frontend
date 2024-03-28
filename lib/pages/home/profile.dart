import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';

class ProfilePage extends StatelessWidget {
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
