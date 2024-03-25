import 'package:digisehat/helpers.dart';
import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _currentStep = 0;
  bool _isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
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
                    Expanded(
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
                          onStepTapped: (step) => _goTo(step),
                          steps: _getSteps(),
                          controlsBuilder:
                              (BuildContext context, ControlsDetails details) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          buildButton(
                              context,
                              _currentStep < 2 ? 'SELANJUTNYA' : 'KONFIRMASI',
                              _currentStep < 2 ? _nextStep : _submitData,
                              alertColor,
                              primaryColor),
                          if (_currentStep > 0)
                            Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                buildButton(context, 'Kembali', _prevStep,
                                    Colors.transparent, alertColor),
                              ],
                            )
                        ],
                      ),
                    )
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
        state: _isComplete ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        _isComplete = true;
      }
    });
  }

  void _prevStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  void _goTo(int step) {
    setState(() => _currentStep = step);
  }

  void _submitData() {
    redirectTo(context, '/home');
  }

  Widget _buildDataPribadiForm() {
    return Column(
      children: <Widget>[
        buildTextField(
            hint: 'Nama',
            obscureText: false,
            prefixIcon: Icons.person,
            iconColor: primaryColor,
            backgroundColor: khakiColor),
        SizedBox(height: 16),
        buildTextField(
            hint: 'NIK',
            obscureText: false,
            prefixIcon: Icons.perm_identity,
            iconColor: primaryColor,
            backgroundColor: khakiColor),
        SizedBox(height: 16),
        buildTextField(
          hint: 'Jenis Kelamin',
          obscureText: false,
          prefixIcon: Icons.male,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
        SizedBox(height: 16),
        buildTextField(
          hint: 'Alamat',
          obscureText: false,
          prefixIcon: Icons.location_city,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
        SizedBox(height: 16),
        buildTextField(
          hint: 'No. Telepon',
          obscureText: false,
          prefixIcon: Icons.phone,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        ),
        SizedBox(height: 16),
        buildTextField(
          hint: 'Tanggal Lahir',
          obscureText: false,
          prefixIcon: Icons.date_range_rounded,
          iconColor: primaryColor,
          backgroundColor: khakiColor,
        )
      ],
    );
  }

  Widget _buildRiwayatPenyakitForm() {
    return Column(
      children: <Widget>[
        buildTextField(
            hint: 'Penyakit / Alergi',
            obscureText: false,
            prefixIcon: Icons.email,
            iconColor: primaryColor,
            backgroundColor: khakiColor),
        SizedBox(height: 16),
        buildTextField(
            hint: 'Tahun',
            obscureText: false,
            prefixIcon: Icons.data_exploration,
            iconColor: primaryColor,
            backgroundColor: khakiColor),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAkunPenggunaForm() {
    return Column(
      children: <Widget>[
        buildTextField(
            hint: 'Email',
            obscureText: false,
            prefixIcon: Icons.email,
            iconColor: primaryColor,
            backgroundColor: khakiColor),
        SizedBox(height: 16),
        buildTextField(
            hint: 'Password',
            obscureText: true,
            prefixIcon: Icons.lock,
            iconColor: primaryColor,
            backgroundColor: khakiColor),
      ],
    );
  }
}
