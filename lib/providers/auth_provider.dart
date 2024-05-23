import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  String endpoint = "http://127.0.0.1:8000";
  UserModel? _user;
  String? errorMessage;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    int? userId = prefs.getInt('user_id');
    if (token != null && userId != null) {
      var userInfo = await _fetchUserInfo(userId, token);
      if (userInfo != null) {
        _user = userInfo;
      }
    }
    notifyListeners();
  }

  Future<UserModel?> _fetchUserInfo(int userId, String token) async {
    var url = Uri.parse('$endpoint/user/$userId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      jsonResponse['access_token'] = token;
      return UserModel.fromJson(jsonResponse);
    }
    return null;
  }

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
      int userId = jsonResponse['user_id'];
      String accessToken = jsonResponse['access_token'];
      _user = UserModel.fromBasic(id: userId, accessToken: accessToken);
      await _saveToken(accessToken);
      await _saveUserId(userId);

      // Fetch full user info
      var userInfo = await _fetchUserInfo(userId, accessToken);
      if (userInfo != null) {
        _user = userInfo;
      }

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
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> _saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
    _user = null;
    notifyListeners();
  }

  bool isAuthenticated() {
    return _user != null;
  }
}
