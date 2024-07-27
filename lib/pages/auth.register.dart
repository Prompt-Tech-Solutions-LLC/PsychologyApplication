import 'package:flutter/material.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({super.key});

  @override
  _AuthRegisterPageState createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final PageController _pageController = PageController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  String? selectedRole;

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.lightBlue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      ),
      obscureText: obscureText,
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = true,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.lightBlue : Colors.lightBlue[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isPrimary ? Colors.white : Colors.lightBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelectionButton({
    required String text,
    required String role,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedRole = role;
          });
          _nextPage();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedRole == role ? Colors.lightBlue : Colors.lightBlue[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedRole == role ? Colors.white : Colors.lightBlue,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Шаг 1: Электронная почта и пароль',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
                const SizedBox(height: 24.0),
                _buildTextField(controller: emailController, labelText: 'Электронная почта'),
                const SizedBox(height: 16.0),
                _buildTextField(controller: passwordController, labelText: 'Пароль', obscureText: true),
                const SizedBox(height: 32.0),
                _buildButton(text: 'Далее', onPressed: _nextPage),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Шаг 2: Имя пользователя',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
                const SizedBox(height: 24.0),
                _buildTextField(controller: usernameController, labelText: 'Имя пользователя'),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildButton(text: 'Назад', onPressed: _previousPage, isPrimary: false),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _buildButton(text: 'Далее', onPressed: _nextPage),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Шаг 3: Личная информация',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
                const SizedBox(height: 24.0),
                _buildTextField(controller: nameController, labelText: 'Имя'),
                const SizedBox(height: 16.0),
                _buildTextField(controller: surnameController, labelText: 'Фамилия'),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildButton(text: 'Назад', onPressed: _previousPage, isPrimary: false),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _buildButton(text: 'Далее', onPressed: _nextPage),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                const Text(
                  'Шаг 4: Выберите роль',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
                const SizedBox(height: 40.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedRole = 'ROLE_USER';
                            });
                            _nextPage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedRole == 'ROLE_USER' ? Colors.lightBlue : Colors.lightBlue[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: Text(
                            'Пользователь',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: selectedRole == 'ROLE_USER' ? Colors.white : Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedRole = 'ROLE_SPECIALIST';
                            });
                            _nextPage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedRole == 'ROLE_SPECIALIST' ? Colors.blueAccent : Colors.lightBlue[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: Text(
                            'Специалист',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: selectedRole == 'ROLE_SPECIALIST' ? Colors.white : Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      _buildButton(
                        text: 'Назад',
                        onPressed: _previousPage,
                        isPrimary: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Подтвердите информацию',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
                const SizedBox(height: 24.0),
                _buildSummaryRow(label: 'Электронная почта', value: emailController.text),
                const SizedBox(height: 16.0),
                _buildSummaryRow(label: 'Имя пользователя', value: usernameController.text),
                const SizedBox(height: 16.0),
                _buildSummaryRow(label: 'Имя', value: nameController.text),
                const SizedBox(height: 16.0),
                _buildSummaryRow(label: 'Фамилия', value: surnameController.text),
                const SizedBox(height: 16.0),
                _buildSummaryRow(label: 'Роль', value: selectedRole == 'ROLE_USER' ? 'Пользователь' : 'Специалист'),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildButton(text: 'Назад', onPressed: _previousPage, isPrimary: false),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _buildButton(
                        text: 'Подтвердить',
                        onPressed: () {
                          // Handle confirmation and submission logic here
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
      ],
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
      debugShowCheckedModeBanner: false,
      home: AuthRegisterPage(),
    );
  }
}
