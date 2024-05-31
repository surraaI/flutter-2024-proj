import 'package:personal_health_tracker/domain/user.dart';

abstract class AdminRepository {
  Future<List<User>> fetchAllUsers();
  Future<void> assignRole(String email, String role);
  Future<void> deleteUser(String email);
  Future<void> deleteAllUsers();
}
