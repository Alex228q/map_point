import 'package:flutter/material.dart';
import 'package:map_point/screens/map_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLogIn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLogIn ? logIn(context) : logUp(context),
      ),
    );
  }

  Widget logIn(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const Text(
            'Добро пожаловать!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 42, 78, 202),
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'Войдите в свой аккаунт, чтобы продолжить использовать все возможности приложения.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 97, 103, 125),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 249, 254),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(17),
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      width: 25,
                    ),
                    const Text(
                      'Google',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 249, 254),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(17),
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/vk.png',
                      width: 25,
                    ),
                    const Text(
                      'VK',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                  child: Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 224, 229, 236),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Или',
                  style: TextStyle(
                      color: Color.fromARGB(255, 97, 103, 125), fontSize: 17),
                ),
              ),
              Expanded(
                  child: Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 224, 229, 236),
              )),
            ],
          ),
          const SizedBox(height: 17),
          Form(
            child: Column(
              children: [
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 38, 38, 38),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 38, 38, 38)),
                    fillColor: const Color.fromARGB(255, 245, 249, 254),
                    filled: true,
                    labelText: 'Почта',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 42, 78, 202),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 38, 38, 38),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 38, 38, 38)),
                    fillColor: const Color.fromARGB(255, 245, 249, 254),
                    filled: true,
                    labelText: 'Пароль',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 42, 78, 202),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 124, 139, 160),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MapScreen();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 52, 97, 253),
                foregroundColor: Colors.white,
                elevation: 2,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'Вход',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              const Text(
                'Нет аккаунта?',
                style: TextStyle(
                  color: Color.fromARGB(255, 59, 64, 84),
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  setState(() {
                    isLogIn = !isLogIn;
                  });
                },
                child: const Text(
                  'Регистрация',
                  style: TextStyle(
                    color: Color.fromARGB(255, 52, 97, 253),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }

  Widget logUp(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const Text(
            'Регистрация',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 42, 78, 202),
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'Зарегестрируйтесь, чтобы продолжить использовать все возможности приложения.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 97, 103, 125),
            ),
          ),
          const SizedBox(height: 24),
          Form(
            child: Column(
              children: [
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 38, 38, 38),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 38, 38, 38)),
                    fillColor: const Color.fromARGB(255, 245, 249, 254),
                    filled: true,
                    labelText: 'Почта',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 42, 78, 202),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 38, 38, 38),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 38, 38, 38)),
                    fillColor: const Color.fromARGB(255, 245, 249, 254),
                    filled: true,
                    labelText: 'Пароль',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 42, 78, 202),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 52, 97, 253),
                foregroundColor: Colors.white,
                elevation: 2,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'Зарегестрироваться',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              const Text(
                'Есть аккаунт?',
                style: TextStyle(
                  color: Color.fromARGB(255, 59, 64, 84),
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  setState(() {
                    isLogIn = !isLogIn;
                  });
                },
                child: const Text(
                  'Войти',
                  style: TextStyle(
                    color: Color.fromARGB(255, 52, 97, 253),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
}
