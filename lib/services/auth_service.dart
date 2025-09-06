import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const storage = FlutterSecureStorage();
  static const String baseUrl = "http://localhost:5000/api/auth";

  static String? _token;
  static Map<String, dynamic>? _user;

  static Future<void> saveToken(String token) async {
    _token = token;
    await storage.write(key: "auth_token", value: token);
  }

  static Future<String?> getToken() async {
    _token ??= await storage.read(key: "auth_token");
    return _token;
  }

  static Future<void> clearToken() async {
    _token = null;
    _user = null;
    await storage.delete(key: "auth_token");
  }

  static Future<Map<String, dynamic>?> getUser() async {
    if (_user != null) return _user;

    final token = await getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$baseUrl/get-auth"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      _user = jsonDecode(response.body);
      return _user;
    } else {
      return null;
    }
  }

  static Map<String, dynamic>? get currentUser => _user;
}
