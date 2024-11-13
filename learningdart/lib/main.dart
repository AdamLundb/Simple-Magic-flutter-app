import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'router.dart';

void main() {
  runApp(MagicCardApp());
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
