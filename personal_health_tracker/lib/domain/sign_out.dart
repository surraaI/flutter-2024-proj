import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/auth/auth_providers.dart';
import 'package:personal_health_tracker/domain/auth_repository.dart';

class SignOut {
  final AuthRepository _authRepository;

  SignOut(this._authRepository);

  Future<void> execute() async {
    await _authRepository.signOut();
  }
}

final signOutProvider = Provider<SignOut>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOut(authRepository);
});
