import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/domain/admin_repository.dart';
import 'package:http/http.dart' as http;
import 'package:personal_health_tracker/infrastructure/auth/admin_repository_impl.dart';

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final client = http.Client();
  const baseUrl = 'http://localhost:3000'; 
  return AdminRepositoryImpl(client, baseUrl);
});
