// auth_repository_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:personal_health_tracker/domain/auth_repository.dart';
import 'package:personal_health_tracker/domain/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final http.Client client;
  final String baseUrl;

  AuthRepositoryImpl(this.client, this.baseUrl);

  String? _authToken;

  @override
  Future<User?> signIn(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      _authToken = responseBody['token'];
      return User.fromJson(responseBody['user']);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<User?> signUp(String username, String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      _authToken = responseBody['token'];
      return User.fromJson(responseBody['user']);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    if (_authToken == null) {
      throw Exception('No authentication token');
    }

    final response = await client.get(
      Uri.parse('$baseUrl/auth/current_user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch current user');
    }
  }

  @override
  Future<void> signOut() async {
    if (_authToken == null) {
      throw Exception('No authentication token');
    }

    final response = await client.post(
      Uri.parse('$baseUrl/auth/signout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken',
      },
    );

    if (response.statusCode == 200) {
      _authToken = null;
    } else {
      throw Exception('Failed to sign out');
    }
  }
}
