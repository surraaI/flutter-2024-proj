import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoading;
  final dynamic user;
  final String? error;

  AuthState({
    required this.isLoading,
    required this.user,
    required this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    dynamic user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState(isLoading: false, user: null, error: null));

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      // Replace with your actual authentication logic
      // final user = await AuthService.signIn(email, password);
      await Future.delayed(Duration(seconds: 2)); // simulate network delay
      final user = {"email": email}; // Mock user object

      state = state.copyWith(isLoading: false, user: user, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signUp(String fullname, String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      // Replace with your actual sign up logic
      // final user = await AuthService.signUp(fullname, email, password);
      await Future.delayed(Duration(seconds: 2)); // simulate network delay
      final user = {"email": email}; // Mock user object

      state = state.copyWith(isLoading: false, user: user, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void signOut() {
    state = AuthState(isLoading: false, user: null, error: null);
  }
}

final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});
