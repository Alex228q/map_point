import 'package:flutter/material.dart';
import 'package:map_point/screens/map_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLog = false;

  void changeMode() {
    setState(() {
      isLog = !isLog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 59, 64, 78),
                  Color.fromARGB(255, 64, 69, 83),
                  Color.fromARGB(255, 59, 64, 78),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 38,
            ),
            child: SingleChildScrollView(
              child: isLog ? logIn() : register(),
            ),
          )
        ],
      ),
    );
  }

  Widget logIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        SizedBox(
          height: 98,
        ),
        Text(
          'Вход',
          style: TextStyle(
            color: Color.fromARGB(255, 254, 254, 254),
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 64),
        Form(
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.amber),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.amber),
                  labelText: 'Почта',
                  labelStyle: TextStyle(color: Colors.amber, fontSize: 18),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22),
              TextFormField(
                style: TextStyle(color: Colors.amber),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.amber),
                  labelText: 'Пароль',
                  labelStyle: TextStyle(color: Colors.amber, fontSize: 18),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 48),
        Align(
          child: SizedBox(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 33, 36, 44),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MapScreen();
                    },
                  ),
                );
              },
              child: Text(
                'Войти',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Нет аккаунта?',
              style: TextStyle(
                color: Color.fromARGB(255, 254, 254, 254),
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: changeMode,
              child: Text(
                'Регистрация.',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget register() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        SizedBox(
          height: 98,
        ),
        Text(
          'Регистрация',
          style: TextStyle(
            color: Color.fromARGB(255, 254, 254, 254),
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 64),
        Form(
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.amber),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.amber),
                  labelText: 'Почта',
                  labelStyle: TextStyle(color: Colors.amber, fontSize: 18),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22),
              TextFormField(
                style: TextStyle(color: Colors.amber),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.amber),
                  labelText: 'Пароль',
                  labelStyle: TextStyle(color: Colors.amber, fontSize: 18),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 48),
        Align(
          child: SizedBox(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 33, 36, 44),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Есть аккаунт?',
              style: TextStyle(
                color: Color.fromARGB(255, 254, 254, 254),
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: changeMode,
              child: Text(
                'Войти.',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
