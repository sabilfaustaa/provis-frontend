import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Cari Dokter', 'redirectLink': '/cari-dokter'},
    {'title': 'Rumah Sakit', 'redirectLink': '/rumah-sakit'},
    {'title': 'Pesan Kamar', 'redirectLink': '/pesan-kamar'},
    {'title': 'Toko Kesehatan', 'redirectLink': '/toko-kesehatan'},
    {'title': 'Layanan Medis', 'redirectLink': '/layanan-medis'},
    {'title': 'Nomor Darurat', 'redirectLink': '/nomor-darurat'},
    {'title': 'Janji Online', 'redirectLink': '/janji-online'},
    {'title': 'Lainnya', 'redirectLink': '/lainnya'},
  ];

  int _selectedIndex = 0;
  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Widget> _pages = [
    Container(color: primaryColor),
    Container(color: secondaryColor),
    Container(color: khakiColor),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: AssetImage('profile-home.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 6),
            DropdownButton(
              items: const [
                DropdownMenuItem(
                  value: "profile",
                  child: Text("Profil"),
                ),
                DropdownMenuItem(
                  value: "change_password",
                  child: Text("Ubah Password"),
                ),
              ],
              onChanged: (value) {},
              hint: Text("Hai, Defrizal", style: lightTextStyle),
              underline: Container(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: secondaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notification_important, color: alertColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari apa yang kamu butuhkan....',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
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
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMarginHome),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  child: PageView(
                    controller: _pageController,
                    children: _pages
                        .map((page) => ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: page,
                            ))
                        .toList(),
                    onPageChanged: (value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  _pages.length, (index) => buildDot(index: index)),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        redirectTo(context, menuItems[index]['redirectLink']);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: primaryColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            menuItems[index]['title'],
                            style: lightTextStyle.copyWith(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Info dan Panduan Aplikasi',
                        style: TextStyle(
                            color: lightColor, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Selengkapnya ->',
                          style: TextStyle(color: lightColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          width: 125,
                          child: Image.asset(
                            'dummy-artikel.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Layanan DigiSehat',
                        style: TextStyle(
                            color: lightColor, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Selengkapnya ->',
                          style: TextStyle(color: lightColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          width: 125,
                          child: Image.asset(
                            'dummy-artikel.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Artikel Digisehat',
                            style: TextStyle(
                                color: lightColor, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Selengkapnya ->',
                              style: TextStyle(color: lightColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryChip('Populer'),
                          _buildCategoryChip('Terbaru'),
                          _buildCategoryChip('Rumah Sakit'),
                          _buildCategoryChip('Kesehatan Mental'),
                          _buildCategoryChip('Produk Obat'),
                          _buildCategoryChip('Vitamin'),
                          _buildCategoryChip('Jiwa Raga'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'assets/dummy-artikel.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Artikel Kesehatan',
                                    style: TextStyle(color: lightColor),
                                  ),
                                  Text(
                                    'Cara Menjaga Kesehatan dengan Memanfaatkan AI dalam Kehidupan Sehari-hari',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: lightColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
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

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? secondaryColor : lightColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildCategoryChip(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(title),
        backgroundColor: primaryColor,
        labelStyle: TextStyle(color: lightColor),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
