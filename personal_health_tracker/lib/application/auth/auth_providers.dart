// auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/domain/auth_repository.dart';
import 'package:personal_health_tracker/domain/sign_in.dart';
import 'package:personal_health_tracker/domain/sign_up.dart';
import 'package:personal_health_tracker/domain/sign_out.dart';
import 'package:personal_health_tracker/infrastructure/auth/auth_repository_impl.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final baseUrlProvider = Provider<String>((ref) {
  return 'http://localhost:3000';
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(httpClientProvider), ref.watch(baseUrlProvider));
});

final signInProvider = Provider<SignIn>((ref) {
  return SignIn(ref.watch(authRepositoryProvider));
});

final signUpProvider = Provider<SignUp>((ref) {
  return SignUp(ref.watch(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(authRepositoryProvider));
});
