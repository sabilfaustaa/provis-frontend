import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hospital.dart';

class HospitalProvider with ChangeNotifier {
  final List<Hospital> _hospitals = [];
  Hospital? _hospital;
  bool _isLoading = false;
  int _skip = 0;
  final int _limit = 15;

  Hospital? get hospital => _hospital;
  List<Hospital> get hospitals => _hospitals;
  bool get isLoading => _isLoading;

  Future<void> fetchHospitals({bool reset = false}) async {
    if (reset) {
      _skip = 0;
      _hospitals.clear();
    }

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      var url = Uri.parse(
          'http://127.0.0.1:8000/hospitals?skip=$_skip&limit=$_limit');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<Hospital> newHospitals = (jsonResponse as List)
            .map((hospital) => Hospital.fromJson(hospital))
            .toList();
        _hospitals.addAll(newHospitals);
        _skip += _limit;
      } else {
        print('Failed to load hospitals: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching hospitals: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchHospitalById(int hospitalId) async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      var url = Uri.parse('http://127.0.0.1:8000/hospital/$hospitalId');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        _hospital = Hospital.fromJson(jsonResponse);
      } else {
        print('Failed to load hospital: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching hospital: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createHospital(Hospital hospital) async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      var url = Uri.parse('http://127.0.0.1:8000/create_hospital');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': hospital.name,
          'address': hospital.address,
          'longitude': hospital.longitude,
          'latitude': hospital.lattitude,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Hospital newHospital = Hospital.fromJson(jsonResponse);
        _hospitals.add(newHospital);
      } else {
        print('Failed to create hospital: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error creating hospital: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _hospitals.clear();
    _skip = 0;
    notifyListeners();
  }
}
