import 'package:digisehat/models/review.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor.dart';

class DoctorProvider with ChangeNotifier {
  List<Doctor> _doctors = [];
  Doctor? _doctor;
  List<Review> _reviews = [];
  bool _isLoading = false;
  int _skip = 0;
  int _limit = 15;
  Doctor? _selectedDoctor;

  Doctor? get doctor => _doctor;
  List<Doctor> get doctors => _doctors;
  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;
  Doctor? get selectedDoctor => _selectedDoctor;

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

  Future<void> fetchDoctor(int doctorId) async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    var url = Uri.parse('http://127.0.0.1:8000/doctor/$doctorId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _doctor = Doctor.fromJson(jsonResponse);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchReviews(int doctorId) async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    var url = Uri.parse('http://127.0.0.1:8000/review_doctor/$doctorId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _reviews = (jsonResponse as List)
          .map((review) => Review.fromJson(review))
          .toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createSchedule(int doctorId, String date, String time,
      String location, int patientId, String reservationNum) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/create_schedule'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'doctor_id': doctorId,
        'date': date,
        'time': time,
        'reservation_num': reservationNum,
        'location': location,
        'patient_id': patientId,
      }),
    );

    return response.statusCode == 200;
  }

  void reset() {
    _doctors.clear();
    _skip = 0;
    notifyListeners();
  }
}
