import 'auth_repository.dart';
import 'user.dart';

class SignIn {
  final AuthRepository authRepository;

  SignIn(this.authRepository);

  Future<User?> execute(String email, String password) {
    return authRepository.signIn(email, password);
  }
}
