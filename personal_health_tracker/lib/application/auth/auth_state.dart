import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/auth/auth_providers.dart';
import 'package:personal_health_tracker/domain/auth_repository.dart';
import 'package:personal_health_tracker/utils/token_storage.dart';
import 'package:personal_health_tracker/utils/jwt_decoder.dart';

class AuthState {
  final bool isLoading;
  final String? token;
  final String? error;
  final String? role;

  AuthState({
    required this.isLoading,
    required this.token,
    required this.error,
    this.role,
  });

  AuthState copyWith({
    bool? isLoading,
    String? token,
    String? error,
    String? role,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      error: error ?? this.error,
      role: role ?? this.role,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthStateNotifier(this.authRepository) : super(AuthState(isLoading: false, token: null, error: null)) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final token = await TokenStorage.getToken();
      if (token != null) {
        final decodedPayload = decodeJWT(token);
        final role = decodedPayload['roles'][0];
        state = state.copyWith(token: token, role: role);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await authRepository.signIn(email, password);
      await TokenStorage.storeToken(token);
      final decodedPayload = decodeJWT(token);
      final role = decodedPayload['roles'][0];
      print(decodedPayload);
      print(role);
      state = state.copyWith(isLoading: false, token: token, role: role, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signUp(String fullname, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await authRepository.signUp(fullname, email, password);
      await TokenStorage.storeToken(token);
      final decodedPayload = decodeJWT(token);
      
      final role = decodedPayload['roles'];
      state = state.copyWith(isLoading: false, token: token, role: role, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await authRepository.signOut();
      await TokenStorage.clearToken();
      state = AuthState(isLoading: false, token: null, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(authRepository);
});
