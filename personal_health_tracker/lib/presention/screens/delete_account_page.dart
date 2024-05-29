// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:personal_health_tracker/presention/widgets/my_button.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final passwordController = TextEditingController();

  void deleteAccount() {
    // Implement delete account functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 41, 81),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
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
            height: 400.0,
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                  radius: 30,
                ),
                SizedBox(height: 15),
                Text(
                  "ጎመን በጤና",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 72, 71, 71),
                  ),
                ),
                SizedBox(height: 50),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 50),
                MyButton(
                  onTap: deleteAccount,
                  buttonText: 'Delete Account',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
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
