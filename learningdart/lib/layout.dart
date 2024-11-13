import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_colors.dart';
import 'destination.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: navigationShell.goBranch,
      indicatorColor: AppColors.primaryColor,
      destinations: destinations
          .map((destination) => NavigationDestination(
            icon: Icon(destination.icon), 
            label: destination.label,
            selectedIcon: Icon(destination.icon, color: AppColors.backgroundColor),
            ))
            .toList(),
    ),
    );
}