abstract class AuthRepository {
  Future<String> signIn(String email, String password);
  Future<void> signOut();
  Future<String> signUp(String fullname, String email, String password);
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<void> deleteAccount(String password);
}
