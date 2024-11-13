import 'package:flutter/material.dart';
import 'package:learningdart/utils/auth_service.dart'; // Import your auth_service
import 'package:learningdart/components.dart';
import 'package:learningdart/app_colors.dart';
import 'package:go_router/go_router.dart';
import '/router.dart'; // Make sure to import your router or routes file

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userNameTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();

  // Function to show a notification dialog
  void showMessageDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle login
  Future<void> handleLogin() async {
    final username = userNameTextField.text;
    final password = passwordTextField.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        await loginUser(username, password);
        // If login is successful, navigate to ProfilePage
        context.go('${Routes.profilePage}?username=$username');
      } catch (e) {
        showMessageDialog(context, 'Login Failed', e.toString());
      }
    } else {
      showMessageDialog(context, 'Error', 'Please fill in all fields.');
    }
  }

  // Function to handle registration
  Future<void> handleRegister() async {
    final username = userNameTextField.text;
    final password = passwordTextField.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        await registerUser(username, password);
        showMessageDialog(context, 'Registration Successful', 'You have successfully registered!');
      } catch (e) {
        showMessageDialog(context, 'Registration Failed', e.toString());
      }
    } else {
      showMessageDialog(context, 'Error', 'Please fill in all fields.');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: customAppBar('Login Page'),
    body: Padding(
      padding: const EdgeInsets.all(96.0),
      child: Column(
        children: [
          TextField(
            controller: userNameTextField,
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(color: AppColors.primaryColor),
              filled: true,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: passwordTextField,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: AppColors.primaryColor),
              filled: true,
            ),
            obscureText: true, // Hide the password
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: handleLogin,
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: handleRegister,
                child: Text('Register'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}