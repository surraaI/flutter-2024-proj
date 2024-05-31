import 'auth_repository.dart';

class SignIn {
  final AuthRepository authRepository;

  SignIn(this.authRepository);

  Future<String?> execute(String email, String password) {
    return authRepository.signIn(email, password);
  }
}
