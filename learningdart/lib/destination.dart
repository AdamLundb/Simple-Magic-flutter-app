import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const List<Destination> loggedOutDestinations = [
  Destination(label: 'Home', icon: Icons.home_outlined),
  Destination(label: 'Login', icon: Icons.login),
];

const List<Destination> loggedInDestinations = [
  Destination(label: 'Home', icon: Icons.home_outlined),
  Destination(label: 'Profile', icon: Icons.person),
  Destination(label: 'Settings', icon: Icons.settings),
];