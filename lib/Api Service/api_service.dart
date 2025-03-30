// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL defined directly.
  static const String _baseUrl = 'http://192.168.95.212:8000';

  /// Sends a POST request to create an account.
  Future<bool> createAccount({
    required String role,
    required int aadhar,
    required String name,
    required String phoneNumber,
    required String password,
    required String city,
  }) async {
    final url = Uri.parse('$_baseUrl/account/$role/create');
    final body = jsonEncode({
      'aadhar': aadhar,
      'name': name,
      'phone_number': phoneNumber,
      'password': password,
      'city': city,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      print(response.body);
      if (response.body == 'true') {
        return true;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}
