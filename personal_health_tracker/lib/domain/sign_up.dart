import 'auth_repository.dart';

class SignUp {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  Future<String?> execute(String fullname, String email, String password) {
    return authRepository.signUp(fullname, email, password);
  }
}
