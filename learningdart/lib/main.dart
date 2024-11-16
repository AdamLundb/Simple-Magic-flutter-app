import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'router.dart';
import 'providers/login_state_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginStateProvider(),
      child: MagicCardApp(),
    ),
  );
}

class MagicCardApp extends StatelessWidget {
  const MagicCardApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: router,
    debugShowCheckedModeBanner: true,
    theme: ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    ),
  );
}
