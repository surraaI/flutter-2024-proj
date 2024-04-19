// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const MyButton({super.key, required this.onTap,required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.fromLTRB(70.0,0.0,70.0,0.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 158, 126, 195),
          borderRadius: BorderRadius.circular(9)
          ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}