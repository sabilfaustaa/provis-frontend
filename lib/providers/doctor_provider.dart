import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor.dart';
import '../models/consultation_schedule.dart';
import '../models/review.dart';

class DoctorProvider with ChangeNotifier {
  List<Doctor> _doctors = [];
  Doctor? _doctor;
  List<Review> _reviews = [];
  bool _isLoading = false;
  int _skip = 0;
  int _limit = 15;
  Doctor? _selectedDoctor;
  ConsultationSchedule? _consultationSchedule;

  Doctor? get doctor => _doctor;
  List<Doctor> get doctors => _doctors;
  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;
  Doctor? get selectedDoctor => _selectedDoctor;
  ConsultationSchedule? get consultationSchedule => _consultationSchedule;

  Future<void> fetchDoctors(String query, {bool reset = false}) async {
    if (reset) {
      _skip = 0;
      _doctors.clear();
    }

    _isLoading = true;
    notifyListeners();

    try {
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

      print(response);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<Doctor> newDoctors = (jsonResponse as List)
            .map((doctor) => Doctor.fromJson(doctor))
            .toList();
        _doctors.addAll(newDoctors);
        _skip += _limit;
      } else {
        print('Failed to load doctors: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching doctors: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDoctor(int doctorId) async {
    _isLoading = true;
    notifyListeners();

    try {
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
      } else {
        print('Failed to load doctor: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching doctor: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDoctorsByName(String name, {bool reset = false}) async {
    if (reset) {
      _skip = 0;
      _doctors.clear();
    }

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      var url = Uri.parse(
          'http://127.0.0.1:8000/doctors/search?search_term=$name&skip=$_skip&limit=$_limit');
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
      } else {
        print('Failed to load doctors: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching doctors: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDoctorsBySpecialty(String specialty,
      {bool reset = false}) async {
    if (reset) {
      _skip = 0;
      _doctors.clear();
    }

    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      var url = Uri.parse(
          'http://127.0.0.1:8000/doctors/searchSpecialty?specialty=$specialty&skip=$_skip&limit=$_limit');
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
      } else {
        print('Failed to load doctors: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching doctors: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReviews(int doctorId) async {
    _isLoading = true;
    notifyListeners();

    try {
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
      } else {
        print('Failed to load reviews: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching reviews: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int?> createSchedule(
    int doctorId,
    String date,
    String time,
    String location,
    int patientId,
    String reservationNum,
    String timestart,
    String timeend,
    String status,
    bool bpjs,
    String? doctorName,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

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
        'timestart': timestart,
        'timeend': timeend,
        'status': status,
        'bpjs': bpjs,
        'doctor_name': doctorName,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['id'];
    } else {
      return null;
    }
  }

  Future<ConsultationSchedule?> fetchConsultationSchedule(int patientId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    var url = Uri.parse('http://127.0.0.1:8000/schedule_patient/$patientId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      _consultationSchedule =
          ConsultationSchedule.fromJson(json.decode(response.body));
      notifyListeners();
      return _consultationSchedule;
    } else {
      throw Exception('Failed to load consultation schedule');
    }
  }

  void reset() {
    _doctors.clear();
    _skip = 0;
    notifyListeners();
  }
}
