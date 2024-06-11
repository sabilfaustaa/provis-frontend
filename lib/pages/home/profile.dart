import 'package:digisehat/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
// import 'package:digisehat/helpers.dart';
import 'package:provider/provider.dart';
import 'package:digisehat/providers/auth_provider.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3;
  bool _isEditing = false;

  TextEditingController _nikController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _bmiController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _medicalHistoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var patient = authProvider.user?.patient;

    if (patient != null) {
      _nikController.text = patient.nik;
      _nameController.text = patient.name;
      _dobController.text = patient.dateOfBirth;
      _genderController.text = patient.gender;
      _addressController.text = patient.address;
      _phoneController.text = patient.telephone ?? '';
      _bmiController.text = patient.bmi?.toString() ?? '';
      _heightController.text = patient.height?.toString() ?? '';
      _weightController.text = patient.weight?.toString() ?? '';
      _medicalHistoryController.text = patient.medicalRecord ?? '';
    }
  }

  int calculateAge(String birthDateString) {
    try {
      DateTime birthDate = DateFormat('yyyy-MM-dd').parse(birthDateString);
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      print("Error calculating age: $e");
      return 0;
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _updateProfile() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      int calculatedAge = calculateAge(_dobController.text);
      print("Calculated Age: $calculatedAge");

      var data = {
        'nik': _nikController.text,
        'name': _nameController.text,
        'date_of_birth': _dobController.text,
        'gender': _genderController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'bmi': double.parse(_bmiController.text),
        'height': int.parse(_heightController.text),
        'weight': int.parse(_weightController.text),
        'medical_record': _medicalHistoryController.text,
        'telephone': _phoneController.text,
        'age': calculatedAge.toString(),
      };

      bool success = await authProvider.updateUserProfile(data);
      if (success) {
        _toggleEdit();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                          Text(authProvider.user?.patient?.name ?? '',
                              style: lightTextStyle.copyWith(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                              '${authProvider.user?.patient?.age ?? ''} Tahun | ${authProvider.user?.patient?.height ?? ''} cm | ${authProvider.user?.patient?.weight ?? ''} Kg',
                              style: lightTextStyle),
                        ],
                      ),
                    ),
                    _buildInfoCard(
                      'Informasi Kontak Pengguna',
                      [
                        'NIK',
                        'Nama Lengkap',
                        'Tanggal Lahir',
                        'Jenis Kelamin',
                        'Alamat Lengkap',
                        'Nomor Telepon',
                      ],
                      priceColor,
                    ),
                    _buildInfoCard(
                      'Informasi Kesehatan Pengguna',
                      [
                        'BMI',
                        'Tinggi Badan',
                        'Berat Badan',
                        'Riwayat Penyakit',
                      ],
                      priceColor,
                    ),
                  ],
                ),
              ),
            ],
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
          // _selectTab(index);
        },
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
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: lightColor),
            onPressed: _isEditing ? _updateProfile : _toggleEdit,
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
        children: items.map((item) {
          return ListTile(
            title: _isEditing
                ? TextField(
                    controller: _getController(item),
                    decoration: InputDecoration(
                      labelText: item,
                      labelStyle: lightTextStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightColor),
                      ),
                    ),
                    style: TextStyle(color: lightColor),
                  )
                : RichText(
                    text: TextSpan(
                      text: '$item: ',
                      style:
                          lightTextStyle.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: _getController(item)?.text ?? '',
                          style: lightTextStyle,
                        ),
                      ],
                    ),
                  ),
          );
        }).toList(),
      ),
    );
  }

  TextEditingController? _getController(String item) {
    switch (item) {
      case 'NIK':
        return _nikController;
      case 'Nama Lengkap':
        return _nameController;
      case 'Tanggal Lahir':
        return _dobController;
      case 'Jenis Kelamin':
        return _genderController;
      case 'Alamat Lengkap':
        return _addressController;
      case 'Nomor Telepon':
        return _phoneController;
      case 'BMI':
        return _bmiController;
      case 'Tinggi Badan':
        return _heightController;
      case 'Berat Badan':
        return _weightController;
      case 'Riwayat Penyakit':
        return _medicalHistoryController;
      default:
        return null;
    }
  }
}
