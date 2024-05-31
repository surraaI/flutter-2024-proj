import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/auth/auth_state.dart';
import 'package:personal_health_tracker/presention/widgets/my_button.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';

class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void changePassword(BuildContext context) async {
      final currentPassword = currentPasswordController.text;
      final newPassword = newPasswordController.text;
      final confirmPassword = confirmPasswordController.text;

      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
        await ref.read(authStateNotifierProvider.notifier).changePassword(currentPassword, newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully')),
        );
        context.go('/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change password: $e')),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 41, 81),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 234, 234, 234),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFB1B1B1),
                  offset: Offset(3, 3),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-10, -10),
                  blurRadius: 10,
                ),
              ],
            ),
            width: 350.0,
            height: 500.0,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                  radius: 30,
                ),
                const SizedBox(height: 15),
                const Text(
                  "ጎመን በጤና",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 72, 71, 71),
                  ),
                ),
                const SizedBox(height: 50),
                MyTextField(
                  controller: currentPasswordController,
                  hintText: "Current Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: newPasswordController,
                  hintText: "New Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm New Password",
                  obscureText: true,
                ),
                const SizedBox(height: 50),
                MyButton(
                  onTap: () {
                    changePassword(context);
                  },
                  buttonText: 'Change Password',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/login');
                      },
                      child: const Text(
                        "Back to Login",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 133, 95, 176),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
