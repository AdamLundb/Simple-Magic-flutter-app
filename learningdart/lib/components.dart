import 'package:flutter/material.dart';
import 'app_colors.dart';

AppBar customAppBar(String titleText) {
  return AppBar(
    title: Text(
      titleText,
      style: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 3.0,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    ),
    backgroundColor: AppColors.backgroundColor,
    centerTitle: true,
    elevation: 4.0, 
  );
}