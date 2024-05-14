import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  String endpoint = "http://127.0.0.1:8000";
  UserModel? _user;
  String? errorMessage;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    var url = Uri.parse('$endpoint/login');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _user = UserModel.fromJson(jsonResponse);
      notifyListeners();
      return true;
    } else {
      errorMessage = "Login gagal";
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    var response = await http.post(
      Uri.parse("$endpoint/signup"),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    _isLoading = false;
    if (response.statusCode == 200) {
      // print('SignUp Success: ${response.body}');
      notifyListeners();
      return true;
    } else {
      // print('SignUp Failed: ${response.body}');
      notifyListeners();
      return false;
    }
  }
}
