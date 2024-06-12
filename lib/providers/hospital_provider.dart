import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hospital.dart';

class HospitalProvider with ChangeNotifier {
  Hospital? _hospital;
  bool _isLoading = false;
  List<Hospital> _hospitals = [];
  int _page = 1;
  final int _limit = 15;

  Hospital? get hospital => _hospital;
  List<Hospital> get hospitals => _hospitals;
  bool get isLoading => _isLoading;

  void reset() {
    _hospitals = [];
    _page = 1;
    notifyListeners();
  }

  Future<void> fetchHospitals({bool reset = false, String query = ''}) async {
    // if (reset) {
    //   reset();
    // }
    _hospitals = [];
    _page = 1;

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/hospitals?page=$_page&query=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List fetchedHospitals = jsonResponse['data'];
        if (reset) {
          _hospitals =
              fetchedHospitals.map((data) => Hospital.fromJson(data)).toList();
        } else {
          _hospitals.addAll(
              fetchedHospitals.map((data) => Hospital.fromJson(data)).toList());
        }
        _page++;
      }
    } catch (error) {
      print("Error fetching hospitals: $error");
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
}
