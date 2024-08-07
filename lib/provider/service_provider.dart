import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Importe SharedPreferences


class ServiceProvider with ChangeNotifier {
  List<Service> _services = [];
  bool _isLoading = false;

  List<Service> get services => _services;
  bool get isLoading => _isLoading;

  Future<void> fetchServices() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://bulir-api.onrender.com/api/service/getAll'); // Altere para a URL da sua API

    try {
      // Obtenha o token do SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? ''; // Use '' como valor padrão

      if (token.isEmpty) {
        throw Exception('Token is not available');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Adicione o token ao cabeçalho
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _services = data.map((json) => Service.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load services');
      }
    } catch (error) {
      print('Error fetching services: $error'); // Adicione um log para depuração
      throw error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
