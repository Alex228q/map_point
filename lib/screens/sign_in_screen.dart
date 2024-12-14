import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 128),
          Text(
            'Вход',
            style: TextStyle(
              color: Color.fromARGB(255, 42, 78, 202),
              fontSize: 34,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 86),
          Container(
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.all(17),
            width: 170,
            child: Row(
              children: [
                Image.asset(
                  'assets/google.png',
                  width: 25,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
