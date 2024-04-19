// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:personal_health_tracker/presention/widgets/my_button.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';

class AdminLogPage extends StatelessWidget {
  AdminLogPage({super.key});

  // text editing controllers
  
  final emailController =TextEditingController();
  final passwordController =TextEditingController();

  // sign user in method
  void signAdminIn(){}

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
            height: 500.0,
              
            child: Column(
              children: [
                SizedBox(height: 20,),
                //curcle or avator logo
                CircleAvatar(
                  // backgroundColor: Colors.white,
                  backgroundImage: AssetImage("image/logo.png"),
                  radius:30 ,
                ),
                  
                SizedBox(height: 15,),
                  
                //text
                Text(
                  "ጎመን በጤና",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 72, 71, 71)
              
                    ),
                ),
                  
                SizedBox(height: 50,),
                 
                //email text field
                MyTextField(
                  controller: emailController, 
                  hintText: "Email", 
                  obscureText: false
                  ),
                SizedBox(height: 10,),
                //password textfeild
                 MyTextField(
                  controller: passwordController, 
                  hintText: "Password", 
                  obscureText: true
                  ),
                SizedBox(height: 50,),
                // sing up btn
                MyButton(
                  onTap: signAdminIn,
                  buttonText: "Login as Admin",
                ),
                SizedBox(height: 10,),
                // textfelid for login link  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Aleady have an account? ",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 133, 95, 176),),),
                    Text("Login",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 133, 95, 176),),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}