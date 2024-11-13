import 'package:flutter/material.dart';
import 'package:learningdart/app_colors.dart';
import 'package:learningdart/utils/card_fetcher_functions.dart';
import 'package:learningdart/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController textField = TextEditingController();
  String? cardImageUrl;
  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void setImageUrlToNull() {
    setState(() {
      cardImageUrl = null;
    });
  }

  void setCardImageUrl(String? url) {
    setState(() {
      cardImageUrl = url;
    });
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Magic Card Finder'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textField,
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
              decoration: InputDecoration(
                labelText: 'Enter card name',
                labelStyle: TextStyle(color: AppColors.primaryColor),
                filled: true,
                fillColor: AppColors.backgroundColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.backgroundColor, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (textField.text.isNotEmpty) {
                  fetchCard(
                    textField.text,
                    setLoading,
                    setCardImageUrl,
                    showErrorDialog,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor, width: 2.0),
              ),
              child: Text(
                'Search',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (cardImageUrl != null)
              Expanded(
                child: GestureDetector(
                  onTap: setImageUrlToNull,
                  child: Image.network(cardImageUrl!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}