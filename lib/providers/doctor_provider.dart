import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/doctor.dart';

class DoctorProvider with ChangeNotifier {
  List<Doctor> _doctors = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Doctor> get doctors => _doctors;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> createDoctor(Doctor doctor) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/create_doctor'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(doctor.toJson()),
      );

      if (response.statusCode == 200) {
        _doctors.add(doctor);
        notifyListeners();
      } else {
        throw Exception('Failed to create doctor');
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDoctors() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/doctors'),
      );

      if (response.statusCode == 200) {
        List<dynamic> doctorsJson = jsonDecode(response.body);
        _doctors = doctorsJson.map((json) => Doctor.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
