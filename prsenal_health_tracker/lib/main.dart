import 'package:flutter/material.dart';
import 'package:prsenal_health_tracker/pages/signUp.dart';
import 'package:prsenal_health_tracker/pages/login.dart';
import 'package:prsenal_health_tracker/pages/adminLog.dart';



void main() => runApp(MyApp(),);


class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
      
    );
  
  }
}