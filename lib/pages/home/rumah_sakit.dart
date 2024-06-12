import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/navigation_bar.dart';
import 'package:digisehat/providers/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RumahSakitPage extends StatefulWidget {
  const RumahSakitPage({super.key});

  @override
  _RumahSakitPageState createState() => _RumahSakitPageState();
}

class _RumahSakitPageState extends State<RumahSakitPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchNameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialHospitals();
    _scrollController.addListener(_scrollListener);
  }

  void _loadInitialHospitals() {
    final hospitalProvider =
        Provider.of<HospitalProvider>(context, listen: false);
    hospitalProvider.reset();
    hospitalProvider.fetchHospitals(reset: true);
  }

  void _scrollListener() {
    final hospitalProvider =
        Provider.of<HospitalProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      hospitalProvider.fetchHospitals();
    }
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
                image: AssetImage('assets/rumah_sakit_image.png'),
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.contain,
              ),
            ),
            child: Padding(
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
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          'Cari Rumah Sakit',
                          style: lightTextStyle.copyWith(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/rumah_sakit_image.png',
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.63,
            minChildSize: 0.63,
            maxChildSize: 1,
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
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
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
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Cari Rumah Sakit',
                              style: TextStyle(
                                  color: lightColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _searchNameController,
                                          decoration: InputDecoration(
                                            hintText:
                                                'Cari berdasarkan nama...',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.search,
                                              color: lightColor),
                                          onPressed: () {
                                            final hospitalProvider =
                                                Provider.of<HospitalProvider>(
                                                    context,
                                                    listen: false);
                                            hospitalProvider.reset();
                                            hospitalProvider.fetchHospitals(
                                                reset: true,
                                                query:
                                                    _searchNameController.text);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<HospitalProvider>(
                        builder: (context, hospitalProvider, child) {
                          if (hospitalProvider.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (hospitalProvider.hospitals.isEmpty) {
                            return Center(
                              child: Text(
                                'Tidak ada rumah sakit ditemukan',
                                style: lightTextStyle,
                              ),
                            );
                          }
                          return ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: hospitalProvider.hospitals.length,
                            itemBuilder: (context, index) {
                              var hospital = hospitalProvider.hospitals[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detail-rumah-sakit',
                                    arguments: hospital.id,
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    hospital.name,
                                    style: lightTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    hospital.address,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.amber),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   'Latitude: ${hospital.latitude}',
                                      //   style: lightTextStyle.copyWith(
                                      //       fontSize: 14,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      Text(
                                        'Longitude: ${hospital.longitude}',
                                        style: lightTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    child: Icon(Icons.local_hospital),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
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
