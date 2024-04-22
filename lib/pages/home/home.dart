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
    {
      'title': 'Cari Dokter',
      'redirectLink': '/cari-dokter',
      'src': 'icon_home/cari_dokter.png',
      'link': ''
    },
    {
      'title': 'Janji Online',
      'redirectLink': '/janji-online',
      'src': 'icon_home/janji_online.png',
      'link': ''
    },
    {
      'title': 'Rumah Sakit',
      'redirectLink': '/rumah-sakit',
      'src': 'icon_home/rumah_sakit.png',
      'link': ''
    },
    {
      'title': 'Rawat Inap',
      'redirectLink': '/pesan-kamar',
      'src': 'icon_home/rawat_inap.png',
      'link': ''
    },
    {
      'title': 'Toko Kesehatan',
      'redirectLink': '/toko-kesehatan',
      'src': 'icon_home/toko_kesehatan.png',
      'link': ''
    },
    {
      'title': 'Layanan Medis',
      'redirectLink': '/layanan-medis',
      'src': 'icon_home/layanan_medis.png',
      'link': ''
    },
    {
      'title': 'Nomor Darurat',
      'redirectLink': '/nomor-darurat',
      'src': 'icon_home/nomor_darurat.png',
      'link': ''
    },
    {
      'title': 'Lainnya',
      'redirectLink': '/lainnya',
      'src': 'icon_home/lainnya.png',
      'link': ''
    },
  ];

  final List<String> listPanduan = [
    'assets/panduan/panduan-1.png',
    'assets/panduan/panduan-2.png',
    'assets/panduan/panduan-3.png',
    'assets/panduan/panduan-4.png',
  ];

  final List<String> listLayanan = [
    'assets/layanan/layanan-1.png',
    'assets/layanan/layanan-2.png',
    'assets/layanan/layanan-3.png',
    'assets/layanan/layanan-4.png',
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
    Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'assets/banner_example.png',
          height: 120,
        ),
      ),
    ),
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
                  height: 120,
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
                            backgroundImage:
                                AssetImage(menuItems[index]['src']),
                            radius: 30,
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
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              listPanduan[index],
                              fit: BoxFit.cover,
                            ),
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
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              listLayanan[index],
                              fit: BoxFit.cover,
                            ),
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
                                'assets/artikel/artikel-1.png',
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
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
                                'assets/artikel/artikel-2.png',
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
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
          SizedBox(height: 4), // Jarak antara ikon dan label
          Text(
            'Gawat Darurat', // Ganti 'Label' dengan teks yang diinginkan
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
