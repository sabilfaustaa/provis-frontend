import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';
import 'package:digisehat/providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _currentStep = 0;
  bool _isComplete = false;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  String? _jenisKelamin;
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _riwayatPenyakitController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(gradientAuthBoxDecoration),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 25.0,
                ),
                height: 700,
                child: Column(
                  children: [
                    _buildHeader(),
                    SizedBox(height: 25),
                    _buildStepper(),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Registrasi Akun',
                  style: lightTextStyle.copyWith(fontSize: 16),
                )),
            SizedBox(height: 8),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Masukan Data Pribadi Anda dengan Benar',
                  style:
                      lightTextStyle.copyWith(fontSize: 26, fontWeight: bolder),
                )),
          ],
        ));
  }

  Widget _buildStepper() {
    return Expanded(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: secondaryColor,
              onPrimary: secondaryColor,
              onSurface: primaryColor,
              background: Colors.transparent,
              shadow: Colors.transparent),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: _nextStep,
          onStepCancel: _prevStep,
          onStepTapped: (step) => setState(() => _currentStep = step),
          steps: _getSteps(),
          controlsBuilder: (context, details) {
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        buildButton(context, _currentStep < 2 ? 'SELANJUTNYA' : 'KONFIRMASI',
            _handleStepControl, alertColor, primaryColor),
        if (_currentStep > 0)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: buildButton(
                context, 'KEMBALI', _prevStep, Colors.transparent, alertColor),
          )
      ],
    );
  }

  List<Step> _getSteps() {
    return [
      Step(
        title: Text(''),
        content: _buildDataPribadiForm(),
        isActive: _currentStep == 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(''),
        content: _buildRiwayatPenyakitForm(),
        isActive: _currentStep == 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(''),
        content: _buildAkunPenggunaForm(),
        isActive: _currentStep == 2,
        state: _currentStep == 2 && _isComplete
            ? StepState.complete
            : StepState.indexed,
      ),
    ];
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _submitData();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  void _handleStepControl() {
    if (_currentStep < 2) {
      _nextStep();
    } else {
      _submitData();
    }
  }

  void _submitData() async {
    final signUpData = {
      'username': _emailController.text,
      'password': _passwordController.text,
      'role': 'Pasien',
    };

    bool isSignUpSuccess =
        await Provider.of<AuthProvider>(context, listen: false)
            .signUp(signUpData);

    if (isSignUpSuccess) {
      final int userId =
          Provider.of<AuthProvider>(context, listen: false).userId;

      final createPatientData = {
        'name': _namaController.text,
        'user_id': userId,
        'nik': _nikController.text,
        'gender': _jenisKelamin,
        'address': _alamatController.text,
        'telephone': _noTeleponController.text,
        'date_of_birth': _tanggalLahirController.text,
        'allergy': _riwayatPenyakitController.text,
        'allergy_year': "-",
        'medical_record': _riwayatPenyakitController.text,
        'password': _passwordController.text,
        'weight': _heightController.text,
        'height': _weightController.text,
        'bmi': _bmiController.text,
        'age': "22",
        'bpjs_status': false,
      };

      bool isCreatePatientSuccess =
          await Provider.of<AuthProvider>(context, listen: false)
              .createPatient(createPatientData);

      if (isCreatePatientSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Pendaftaran berhasil!"),
          backgroundColor: Colors.green,
        ));
        Navigator.pushNamed(context, '/sign-in');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Pendaftaran gagal pada tahap create patient, coba lagi."),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Pendaftaran gagal pada tahap signup, coba lagi."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget _buildDataPribadiForm() {
    return Column(
      children: [
        buildTextField(
          controller: _namaController,
          hint: 'Nama',
          obscureText: false,
          prefixIcon: Icons.person,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
        SizedBox(height: 16),
        buildTextField(
          controller: _nikController,
          hint: 'NIK',
          obscureText: false,
          prefixIcon: Icons.perm_identity,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                value: 'Laki-laki',
                groupValue: _jenisKelamin,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value as String?;
                  });
                },
                title: Text('Laki-laki', style: TextStyle(color: Colors.white)),
              ),
            ),
            Expanded(
              child: RadioListTile(
                value: 'Perempuan',
                groupValue: _jenisKelamin,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value as String?;
                  });
                },
                title: Text('Perempuan', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildTextField(
          controller: _alamatController,
          hint: 'Alamat',
          obscureText: false,
          prefixIcon: Icons.location_city,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
          maxLines: 4,
        ),
        SizedBox(height: 16),
        buildTextField(
          controller: _noTeleponController,
          hint: 'No. Telepon',
          obscureText: false,
          prefixIcon: Icons.phone,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                _tanggalLahirController.text = formattedDate;
              });
            }
          },
          child: AbsorbPointer(
            child: buildTextField(
              controller: _tanggalLahirController,
              hint: 'Tanggal Lahir',
              obscureText: false,
              prefixIcon: Icons.date_range_rounded,
              iconColor: primaryColor,
              backgroundColor: khakiColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRiwayatPenyakitForm() {
    return Column(
      children: [
        buildTextField(
          controller: _riwayatPenyakitController,
          hint: 'Masukan riwayat penyakit/alergi beserta tahun mengalaminya',
          obscureText: false,
          prefixIcon: null,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
          maxLines: 6,
        ),
        buildTextField(
          controller: _weightController,
          hint: 'Masukan Berat Badan',
          obscureText: false,
          prefixIcon: null,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
          maxLines: 6,
        ),
        buildTextField(
          controller: _heightController,
          hint: 'Masukan Tinggi Badan',
          obscureText: false,
          prefixIcon: null,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
          maxLines: 6,
        ),
        buildTextField(
          controller: _bmiController,
          hint: 'Masukan BMI',
          obscureText: false,
          prefixIcon: null,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
          maxLines: 6,
        ),
      ],
    );
  }

  Widget _buildAkunPenggunaForm() {
    return Column(
      children: [
        buildTextField(
          controller: _emailController,
          hint: 'Email',
          obscureText: false,
          prefixIcon: Icons.email,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
        SizedBox(height: 16),
        buildTextField(
          controller: _passwordController,
          hint: 'Password',
          obscureText: true,
          prefixIcon: Icons.lock,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
      ],
    );
  }
}
