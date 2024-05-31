import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:personal_health_tracker/domain/auth_repository.dart';
import 'package:personal_health_tracker/utils/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final http.Client client;
  final String baseUrl;

  AuthRepositoryImpl(this.client, this.baseUrl);

  @override
  Future<String> signIn(String email, String password) async {
    final requestBody = jsonEncode({'email': email, 'password': password});

    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      return token; 
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to sign in';
      throw Exception(error);
    }
  }

  @override
  Future<String> signUp(String fullname, String email, String password) async {
    final requestBody = jsonEncode({'fullname': fullname, 'email': email, 'password': password});

    final response = await client.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      return token; 
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to sign up';
      throw Exception(error);
    }
  }

  @override
  Future<void> signOut() async {
    await TokenStorage.clearToken();
  }
}
