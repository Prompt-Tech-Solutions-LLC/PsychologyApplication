import 'package:flutter/material.dart';
import 'auth.register.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showLimitedAccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            'Ограниченный доступ',
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'У вас будет ограниченный доступ к приложению, вы уверены?',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Отмена',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).maybePop(); // Go back to the previous page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text(
                'Да',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Авторизация',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Электронная почта',
                filled: true,
                fillColor: Colors.lightBlue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                prefixIcon: Icon(Icons.email, color: Colors.lightBlue[800]),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Пароль',
                filled: true,
                fillColor: Colors.lightBlue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                prefixIcon: Icon(Icons.lock, color: Colors.lightBlue[800]),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle login logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                ),
                child: const Text('Войти', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AuthRegisterPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Регистрация', style: TextStyle(color: Colors.lightBlue)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 4.0),
                    child: TextButton(
                      onPressed: () {
                        _showLimitedAccessDialog(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Продолжить как гость', style: TextStyle(color: Colors.lightBlue)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Страница авторизации',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthLoginPage(),
    );
  }
}
