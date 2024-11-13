import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'layout.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class Routes {
  static const String homePage = '/home';
  static const String loginPage = '/login';
  static const String profilePage = '/profile';
}

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.homePage,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.homePage,
              builder: (context, state) => const HomePage(),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.loginPage,
              builder: (context, state) => const LoginPage(),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profilePage,
              builder: (context, state) {
                final username = state.uri.queryParameters['username'] ?? 'User';
                return ProfilePage(username: username);
              },
            ),
          ]
        ),
      ]
    )
  ],
);