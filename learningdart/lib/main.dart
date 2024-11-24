import 'package:flutter/material.dart';
import 'package:learningdart/providers/card_state_provider.dart';
import 'app_colors.dart';
import 'router.dart';
import 'providers/login_state_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginStateProvider()),
        ChangeNotifierProvider(create: (context) => CardStateProvider()),
      ],
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