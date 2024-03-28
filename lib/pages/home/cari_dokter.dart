import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/navigation_bar.dart';
import 'package:flutter/material.dart';

class CariDokterPage extends StatefulWidget {
  @override
  _CariDokterPageState createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  int _selectedIndex = 0;
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
          Container(
            color: primaryColor,
            child: Center(
              child: Text('Peta Akan Ditampilkan Di Sini',
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.70,
            minChildSize: 0.70,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: darkPrimaryColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
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
                        SizedBox(height: 16),
                        Text(
                          'Cari Dokter',
                          style: TextStyle(
                              color: lightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Cari apa yang kamu butuhkan....',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: khakiColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dokter Teratas',
                                style: TextStyle(
                                    color: lightColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Lihat Semuanya',
                                  style: TextStyle(color: lightColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...List.generate(
                            20,
                            (index) => ListTile(
                                  title: Text('Dr. Ahmad Taufik',
                                      style: lightTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                    'Dokter Kandungan',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.amber),
                                  ),
                                  trailing: Text(
                                    '2.1 KM',
                                    style: lightTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                )),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.warning,
          size: 28,
        ),
        backgroundColor: alertColor,
        elevation: 2.0,
        shape: CircleBorder(),
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
