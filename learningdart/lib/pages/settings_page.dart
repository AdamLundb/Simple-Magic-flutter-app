import 'package:flutter/material.dart';
import 'package:learningdart/components.dart';
import 'package:provider/provider.dart';
import 'package:learningdart/providers/login_state_provider.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Settings'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, This is the settings page'),
            ElevatedButton(
              onPressed: () {
                context.read<LoginStateProvider>().logOut();
                context.go('/home');
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}