import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  User? _user;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  double _balance = 0.0; // Novo campo para saldo

  User? get user => _user;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  double get balance => _balance; // Getter para saldo

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    notifyListeners();

    // Recuperar o token do SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('token');
    final userId = prefs.getString('userId');

    if (userId == null || authToken == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://bulir-api.onrender.com/api/user/getById/$userId'),
        headers: {
          'Authorization': 'Bearer $authToken', // Inclui o token nos cabeçalhos
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _user = User.fromJson(data);

        // Atualizar o saldo com base na resposta da API, ajuste conforme necessário
        _balance = data['balance'] ?? 0.0; // Ajuste baseado na estrutura da sua resposta
      } else {
        // Tratar erro
      }
    } catch (error) {
      // Tratar exceção
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserTransactions() async {
    _isLoading = true;
    notifyListeners();

    // Recuperar o token do SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    final userId = prefs.getString('user_id');

    if (userId == null || authToken == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://bulir-api.onrender.com/api/transaction/history/$userId'),
        headers: {
          'Authorization': 'Bearer $authToken', // Inclui o token nos cabeçalhos
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _transactions = data.map((item) => Transaction.fromJson(item)).toList();
      } else {
        // Tratar erro
      }
    } catch (error) {
      // Tratar exceção
    }

    _isLoading = false;
    notifyListeners();
  }
}
