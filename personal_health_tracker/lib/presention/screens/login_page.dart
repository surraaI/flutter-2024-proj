import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/application/auth/auth_state.dart';
import 'package:personal_health_tracker/presention/widgets/my_button.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUserIn() async {
    final notifier = ref.read(authStateNotifierProvider.notifier);
    await notifier.signIn(emailController.text, passwordController.text);

    if (!mounted) return; // Check if the widget is still mounted

    final authState = ref.read(authStateNotifierProvider);

    if (authState.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: ${authState.error}')),
      );
    } else if (authState.user != null) {
      context.go('/home'); // Use go_router for navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

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
                const SizedBox(height: 20,),
                const CircleAvatar(
                  backgroundImage: AssetImage("images/logo.png"),
                  radius: 30,
                ),
                const SizedBox(height: 15,),
                const SizedBox(height: 50,),
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 50,),
                if (authState.isLoading)
                  const CircularProgressIndicator(),
                if (!authState.isLoading)
                  MyButton(
                    onTap: signUserIn,
                    buttonText: 'Log In',
                  ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/signup'); // Use go_router for navigation
                      },
                      child: const Text(
                        "Sign Up",
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
