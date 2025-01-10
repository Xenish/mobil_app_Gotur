import 'package:flutter/material.dart';
import 'package:mobil_app/models/user_data.dart';
import 'package:mobil_app/screens/home_home_screen.dart';
import 'package:mobil_app/widgets/auth_screen_template.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (UserData.username == _usernameController.text &&
        UserData.password == _passwordController.text) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeHomeScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: const Text('Kullanıcı adı veya şifre yanlış.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigo),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              'Götür',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          // Sağdaki ikon boş olacak
        ],
      ),
      body: buildAuthScreen(
        context,
        title: 'Giriş Yap',
        usernameController: _usernameController,
        passwordController: _passwordController,
        onSubmit: () => _login(context),
      ),
    );
  }
}
