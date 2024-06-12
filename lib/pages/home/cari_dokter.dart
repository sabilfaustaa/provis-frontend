import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/navigation_bar.dart';
import 'package:digisehat/providers/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CariDokterPageState createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchNameController = TextEditingController();
  final TextEditingController _searchSpecialtyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialDoctors();
    _scrollController.addListener(_scrollListener);
  }

  void _loadInitialDoctors() {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    doctorProvider.reset();
    doctorProvider.fetchDoctorsByName('', reset: true);
  }

  void _scrollListener() {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      doctorProvider.fetchDoctorsByName(_searchNameController.text);
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
    _searchSpecialtyController.dispose();
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
                image: AssetImage('assets/cari_dokter_image.png'),
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
                          'Cari Dokter',
                          style: lightTextStyle.copyWith(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  Image.network(
                    "assets/dokter.png",
                    width: double.infinity,
                    fit: BoxFit.contain,
                  )
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
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Cari Dokter',
                              style: TextStyle(
                                  color: lightColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          )
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
                                                'Cari berdasarkan nama atau spesialisasi...',
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
                                      SizedBox(
                                        width: 10,
                                      ),
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
                                            final doctorProvider =
                                                Provider.of<DoctorProvider>(
                                                    context,
                                                    listen: false);
                                            doctorProvider.fetchDoctorsByName(
                                                _searchNameController.text,
                                                reset: true);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 10),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: TextField(
                                  //         controller:
                                  //             _searchSpecialtyController,
                                  //         decoration: InputDecoration(
                                  //           hintText:
                                  //               'Cari berdasarkan spesialisasi...',
                                  //           contentPadding:
                                  //               EdgeInsets.symmetric(
                                  //                   horizontal: 10.0),
                                  //           border: OutlineInputBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10.0),
                                  //           ),
                                  //           filled: true,
                                  //           fillColor: khakiColor,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Container(
                                  //       decoration: BoxDecoration(
                                  //         color: alertColor,
                                  //         borderRadius:
                                  //             BorderRadius.circular(10.0),
                                  //       ),
                                  //       child: IconButton(
                                  //         icon: Icon(Icons.search,
                                  //             color: lightColor),
                                  //         onPressed: () {
                                  //           final doctorProvider =
                                  //               Provider.of<DoctorProvider>(
                                  //                   context,
                                  //                   listen: false);
                                  //           doctorProvider
                                  //               .fetchDoctorsBySpecialty(
                                  //                   _searchSpecialtyController
                                  //                       .text,
                                  //                   reset: true);
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<DoctorProvider>(
                        builder: (context, doctorProvider, child) {
                          if (doctorProvider.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Column(
                            children: doctorProvider.doctors.map((doctor) {
                              return InkWell(
                                onTap: () {
                                  // redirectTo(context, "/detail-dokter");
                                  Navigator.pushNamed(
                                    context,
                                    '/detail-dokter',
                                    arguments: doctor.id,
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    doctor.name,
                                    style: lightTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    doctor.specialty,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.amber),
                                  ),
                                  trailing: Text(
                                    '10 KM',
                                    style: lightTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      )
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
