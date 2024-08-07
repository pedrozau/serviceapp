import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _role;

  String? get userId => _userId;
  String? get role => _role;

  String? get token => _token;

  AuthProvider() {
    _loadToken(); // Load token from shared preferences on initialization
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('https://bulir-api.onrender.com/api/auth/signin');
    print(email);
    print(password);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      _token = data['access_token'];
      _userId = data['user']['id'];
      _role = data['user']['role']; // Assuming response contains a token
      print(_userId);
      // Save token to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userId', _userId!);
      await prefs.setString('role', _role!);

      notifyListeners();
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<void> logout() async {
    _token = null;

    // Remove token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    notifyListeners();
  }
}
