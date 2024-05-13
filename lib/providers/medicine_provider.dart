import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/medicine.dart';

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Medicine> get medicines => _medicines;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> createMedicine(Medicine medicine) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/create_medicine'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(medicine.toJson()),
      );

      if (response.statusCode == 200) {
        _medicines.add(medicine);
        notifyListeners();
      } else {
        throw Exception('Failed to create medicine');
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMedicines() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/medicines'),
      );

      if (response.statusCode == 200) {
        List<dynamic> medicinesJson = jsonDecode(response.body);
        _medicines =
            medicinesJson.map((json) => Medicine.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load medicines');
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
