import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/admin/admin_providers.dart';
import 'package:personal_health_tracker/application/auth/auth_providers.dart';
import 'package:personal_health_tracker/domain/admin_repository.dart';
import 'package:personal_health_tracker/domain/user.dart';

class AdminState {
  final bool isLoading;
  final List<User> users;
  final String? error;

  AdminState({
    required this.isLoading,
    required this.users,
    required this.error,
  });

  AdminState copyWith({
    bool? isLoading,
    List<User>? users,
    String? error,
  }) {
    return AdminState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }
}

class AdminStateNotifier extends StateNotifier<AdminState> {
  final AdminRepository adminRepository;

  AdminStateNotifier(this.adminRepository) : super(AdminState(isLoading: false, users: [], error: null));

  Future<void> fetchAllUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final users = await adminRepository.fetchAllUsers();
      state = state.copyWith(isLoading: false, users: users, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> assignRole(String email, String role) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await adminRepository.assignRole(email, role);
      await fetchAllUsers(); 
      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteUser(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await adminRepository.deleteUser(email);
      await fetchAllUsers(); 
      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteAllUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await adminRepository.deleteAllUsers();
      state = state.copyWith(isLoading: false, users: [], error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final adminStateNotifierProvider = StateNotifierProvider<AdminStateNotifier, AdminState>((ref) {
  final adminRepository = ref.watch(adminRepositoryProvider);
  return AdminStateNotifier(adminRepository);
});
