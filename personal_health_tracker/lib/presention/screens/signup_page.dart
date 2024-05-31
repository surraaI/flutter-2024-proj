import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/application/auth/auth_state.dart';
import 'package:personal_health_tracker/presention/widgets/my_button.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUserUp() async {
    final notifier = ref.read(authStateNotifierProvider.notifier);
    await notifier.signUp(
      fullnameController.text,
      emailController.text,
      passwordController.text,
    );

    if (!mounted) return;

    final authState = ref.read(authStateNotifierProvider);

    if (authState.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: ${authState.error}')),
      );
    } else if (authState.token != null) {
      context.go('/home');
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
                  controller: fullnameController,
                  hintText: "Full Name",
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
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
                    onTap: signUserUp,
                    buttonText: 'Sign Up',
                  ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 133, 95, 176),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/login');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 133, 95, 176),
                          decoration: TextDecoration.underline,
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
