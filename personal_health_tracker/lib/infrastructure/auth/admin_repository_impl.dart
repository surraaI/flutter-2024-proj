import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:personal_health_tracker/domain/admin_repository.dart';
import 'package:personal_health_tracker/domain/user.dart';

class AdminRepositoryImpl implements AdminRepository {
  final http.Client client;
  final String baseUrl;

  AdminRepositoryImpl(this.client, this.baseUrl);

  @override
  Future<List<User>> fetchAllUsers() async {
    final response = await client.get(Uri.parse('$baseUrl/admin/users'));

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      return responseBody.map((user) => User.fromJson(user)).toList();
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to fetch users';
      throw Exception(error);
    }
  }

  @override
  Future<void> assignRole(String email, String role) async {
    final requestBody = jsonEncode({'email': email, 'role': role});

    final response = await client.put(
      Uri.parse('$baseUrl/admin/assign-role'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to assign role';
      throw Exception(error);
    }
  }

  @override
  Future<void> deleteUser(String email) async {
    final requestBody = jsonEncode({'email': email});

    final response = await client.delete(
      Uri.parse('$baseUrl/admin/delete-user'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to delete user';
      throw Exception(error);
    }
  }

  @override
  Future<void> deleteAllUsers() async {
    final response = await client.delete(Uri.parse('$baseUrl/admin/delete-all-users'));

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body)['message'] ?? 'Failed to delete all users';
      throw Exception(error);
    }
  }
}
