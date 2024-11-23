import 'package:flutter/material.dart';
import 'package:learningdart/utils/auth_service.dart';
import 'package:learningdart/components.dart';
import 'package:learningdart/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:learningdart/providers/login_state_provider.dart';
import 'package:provider/provider.dart';
import '/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userNameTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();

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
  Future<void> handleLogin() async {
    final username = userNameTextField.text;
    final password = passwordTextField.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        // Get user data from the login API
        final loginData = await loginUser(username, password);
        final userId = loginData['userId'];
        final loggedInUsername = loginData['username'];

        // Update the provider with the logged-in user data
        context.read<LoginStateProvider>().logIn(userId, loggedInUsername);

        // Navigate to the profile page with the username
        context.go('${Routes.profilePage}?username=$loggedInUsername');
      } catch (e) {
        showMessageDialog(context, 'Login Failed', e.toString());
      }
    } else {
      showMessageDialog(context, 'Error', 'Please fill in all fields.');
    }
  }

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
            obscureText: true,
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