import 'auth_repository.dart';
import 'user.dart';

class SignUp {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  Future<User?> execute(String fullname, String email, String password) {
    return authRepository.signUp(fullname, email, password);
  }
}
