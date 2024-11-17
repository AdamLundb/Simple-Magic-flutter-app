import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/login_state_provider.dart';
import 'destination.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<LoginStateProvider>().isLoggedIn;
    final currentDestinations = isLoggedIn ? loggedInDestinations : loggedOutDestinations;
    final indexMapping = isLoggedIn
        ? [0, 2, 3] 
        : [0, 1];  

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: indexMapping.indexOf(navigationShell.currentIndex),
        onDestinationSelected: (index) {
          print('index: $index, branch index: ${indexMapping[index]}, Logged in: $isLoggedIn');
          navigationShell.goBranch(indexMapping[index]);
        },
        destinations: currentDestinations
            .map(
              (destination) => NavigationDestination(
                icon: Icon(destination.icon),
                label: destination.label,
              ),
            )
            .toList(),
      ),
    );
  }
}