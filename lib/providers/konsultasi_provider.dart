import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/consultation_schedule.dart';

class KonsultasiProvider with ChangeNotifier {
  ConsultationSchedule? _consultationSchedule;

  ConsultationSchedule? get consultationSchedule => _consultationSchedule;

  Future<ConsultationSchedule?> fetchConsultationScheduleById(
      int scheduleId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    var url = Uri.parse('http://127.0.0.1:8000/schedule/$scheduleId');
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
}
