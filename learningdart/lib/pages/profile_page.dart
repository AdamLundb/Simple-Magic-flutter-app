import 'package:flutter/material.dart';
import 'package:learningdart/components.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Profile'),
      body: Center(
        child: Text(
          'Hello, $username!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}