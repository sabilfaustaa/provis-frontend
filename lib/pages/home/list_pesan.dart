import 'package:digisehat/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';

class ListPesanPage extends StatefulWidget {
  const ListPesanPage({super.key});

  @override
  State<ListPesanPage> createState() => _ListPesanPageState();
}

class _ListPesanPageState extends State<ListPesanPage> {
  int _selectedIndex = 1;
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.arrow_back, color: lightColor),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      Text(
                        'Pesan',
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
                              hintText: 'Cari pesan....',
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        redirectTo(context, "/pesan");
                      },
                      child: TransactionCard(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.warning,
              size: 28,
            ),
            backgroundColor: alertColor,
            elevation: 2.0,
            shape: CircleBorder(),
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
  const TransactionCard({Key? key}) : super(key: key);

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
              'assets/ijay.png', // Replace with your image URL.
              height: 130,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dr. Ahmad Hanif',
                  style:
                      lightTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                ),
                Text(
                  'Dokter Kandungan',
                  style: lightTextStyle.copyWith(fontWeight: medium),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Tidak perlu berterima kasih. Saya senang bisa ...',
                  style: lightTextStyle.copyWith(fontSize: 12),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // buildButton(context, "Lihat Detail", () {}, orangeColor,
                    //     lightColor)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
