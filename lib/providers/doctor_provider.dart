import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor.dart';
import '../providers/auth_provider.dart';

class DoctorProvider with ChangeNotifier {
  List<Doctor> _doctors = [];
  bool _isLoading = false;
  int _skip = 0;
  int _limit = 15;

  List<Doctor> get doctors => _doctors;
  bool get isLoading => _isLoading;

  Future<void> fetchDoctors(String query, {bool reset = false}) async {
    if (reset) {
      _skip = 0;
      _doctors.clear();
    }

    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    var url = Uri.parse(
        'http://127.0.0.1:8000/doctors?skip=$_skip&limit=$_limit&query=$query');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<Doctor> newDoctors = (jsonResponse as List)
          .map((doctor) => Doctor.fromJson(doctor))
          .toList();
      _doctors.addAll(newDoctors);
      _skip += _limit;
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _doctors.clear();
    _skip = 0;
    notifyListeners();
  }
}
