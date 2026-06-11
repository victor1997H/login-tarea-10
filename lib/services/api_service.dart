import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  Future<bool> register(
    String name,
    String username,
    String password,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userData = {
        'name': name,
        'password': password,
      };

      await prefs.setString(
        username,
        jsonEncode(userData),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(
    String username,
    String password,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userRaw = prefs.getString(username);

      if (userRaw == null) return false;

      final userData = jsonDecode(userRaw);

      return userData['password'] == password;

    } catch (e) {
      return false;
    }
  }
}