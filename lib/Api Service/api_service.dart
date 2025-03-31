// api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<bool> login({
    required String role,
    required int aadhar,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/account/$role/login').replace(
      queryParameters: {'aadhar': aadhar.toString(), 'password': password},
    );

    try {
      final response = await http.get(url);
      if (response.body == 'true') {
        return true;
      } else {
        print('Login error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Login exception: $e');
      return false;
    }
  }

  Future<String> verifyPhotos({
    required File frontImage,
    required File backImage,
  }) async {
    final uri = Uri.parse('$_baseUrl/ai/image'); // Adjust endpoint as needed.
    final request = http.MultipartRequest('POST', uri);

    try {
      // Determine MIME type for the front image.
      final frontMimeType =
          lookupMimeType(frontImage.path) ?? 'application/octet-stream';
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Using "file" as the field name for both images.
          frontImage.path,
          contentType: MediaType.parse(frontMimeType),
        ),
      );

      // Determine MIME type for the back image.
      final backMimeType =
          lookupMimeType(backImage.path) ?? 'application/octet-stream';
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Using "file" as the field name for both images.
          backImage.path,
          contentType: MediaType.parse(backMimeType),
        ),
      );

      // Send the multipart request.
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      print(responseString);
      // Check the response status.
      if (response.statusCode == 200) {
        return responseString; // Return the backend's text response.
      } else {
        throw Exception(
          'Server error (${response.statusCode}): $responseString',
        );
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<String> submitProductDetails({
    required String company,
    required String model,
    required String variant,
    required String imei,
    required String colour,
    required String verificationResponse,
    required String type,
  }) async {
    // Combine details into a single comma-separated string.
    final details = "$company,$model,$variant,$imei,$colour";

    // Create URI with a single query parameter named "data".
    final uri = Uri.parse('$_baseUrl/ai/gist/' + details);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        'Server error (${response.statusCode}): ${response.body}',
      );
    }
  }

  /// Wrapper function for consistency.
  Future<String> submitProductDetailsWrapper({
    required String company,
    required String model,
    required String variant,
    required String imei,
    required String colour,
    required String verificationResponse,
    required String type,
  }) {
    return submitProductDetails(
      company: company,
      model: model,
      variant: variant,
      imei: imei,
      colour: colour,
      verificationResponse: verificationResponse,
      type: type,
    );
  }

  Future<String> registerOrder({
    required int aadhar,
    required String imageUrl,
    required String type,
    required String company,
    required String model,
    required String variant,
    required String imei,
    required String color,
    required int status,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/order/create',
    ); // Adjust endpoint as needed.
    final body = jsonEncode({
      "aadhar": aadhar,
      "image_url": imageUrl,
      "type": type,
      "company": company,
      "model": model,
      "variant": variant,
      "imei": imei,
      "color": color,
      "status": status,
    });

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    var order = jsonDecode(response.body);
    final vendoralot = Uri.parse('$_baseUrl/add/vendor/$order');
    final response2 = await http.get(vendoralot);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception(
        'Server error (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<int> fetchTrackingStatus({required String orderId}) async {
    final uri = Uri.parse("$_baseUrl/track/$orderId/status");
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the response body into an integer.
      return int.parse(response.body.trim());
    } else {
      throw Exception(
        "Server error: ${response.statusCode} - ${response.body}",
      );
    }
  }

  Future<List<Map<String, dynamic>>> getVendorOrders() async {
    final uri = Uri.parse('$_baseUrl/get/vendor');
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      // Assuming your backend returns a JSON array of order objects.
      final List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}
