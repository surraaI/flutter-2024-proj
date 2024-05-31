import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/change_password');
              },
              child: const Text('Change Password'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.push('/delete_account');
              },
              child: const Text('Delete Account'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await authStateNotifier.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
