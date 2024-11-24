import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/login_state_provider.dart';
import 'providers/card_state_provider.dart';
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
          final branchIndex = indexMapping[index];
          print('index: $index, branch index: $branchIndex, Logged in: $isLoggedIn');

          if (branchIndex == 2) { 
            final userId = context.read<LoginStateProvider>().userId!;
            context.read<CardStateProvider>().fetchCards(userId);
          }

          navigationShell.goBranch(branchIndex);
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