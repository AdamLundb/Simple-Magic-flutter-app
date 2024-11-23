import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://10.0.2.2:3000';

Future<void> registerUser(String username, String password) async {
  final url = Uri.parse('$baseUrl/users/register');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    print('User registered successfully: ${jsonDecode(response.body)}');
  } else {
    throw Exception('Failed to register: ${jsonDecode(response.body)['error']}');
  }
}

Future<Map<String, dynamic>> loginUser(String username, String password) async {
  final url = Uri.parse('$baseUrl/users/login');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Login successful: ${data['message']}');
    print('User ID: ${data['userId']}');
    return {
      'userId': data['userId'],
      'username': username,
    };
  } else {
    throw Exception('Failed to login: ${jsonDecode(response.body)['error']}');
  }
}