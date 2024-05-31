import 'package:personal_health_tracker/domain/user.dart';

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Future<User?> signUp(String fullname, String email, String password);
}

