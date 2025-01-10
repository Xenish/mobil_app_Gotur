import 'package:flutter/material.dart';

Widget buildAuthScreen(
  BuildContext context, {
  required String title,
  required TextEditingController usernameController,
  required TextEditingController passwordController,
  required VoidCallback onSubmit,
}) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpeg'), // Arka plan resmi
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 16),
            buildInputField(usernameController, 'Kullanıcı Adı'),
            SizedBox(height: 16),
            buildInputField(passwordController, 'Şifre', isPassword: true),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSubmit,
              child: Text(title, style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildInputField(TextEditingController controller, String label, {bool isPassword = false}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.indigo,
      border: Border.all(color: Colors.indigo, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(8),
      ),
      obscureText: isPassword,
    ),
  );
}
