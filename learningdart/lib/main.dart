import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_colors.dart';

void main() {
  runApp(MagicCardApp());
}

class MagicCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Card Viewer',
      home: CardSearchScreen(),
    );
  }
}

class CardSearchScreen extends StatefulWidget {
  @override
  CardSearchScreenState createState() => CardSearchScreenState();
}

class CardSearchScreenState extends State<CardSearchScreen> {
  TextEditingController textField = TextEditingController();
  bool isLoading = false;
  String? cardImageUrl;

  Future<void> fetchCard(String cardName) async{
    setLoading(true);
    try {
      final response = await http.get(Uri.parse('https://api.scryfall.com/cards/named?fuzzy=$cardName'));
      if (response.statusCode == 200) {
        final selectedCard = jsonDecode(response.body);
        setState(() {
          cardImageUrl = selectedCard['image_uris']['normal'];
        });
      } else {
        setImageUrlToNull();
        errorDialog("Couldn't get the card. Error code: ${response.statusCode}");
      }
    } catch(e) {
        setImageUrlToNull();
        errorDialog("Couldn't get the card. Error : ${e.toString()}");
    } finally {
      setState(() {
        setLoading(false);
      });
    }
  }

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

  void errorDialog(String errorMessage) {
    showDialog(context: context
    , builder: (context) => AlertDialog(
      title: Text('Error'),
      content: Text(errorMessage),
      actions: [
        TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('OK'),
        )
      ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                labelStyle: TextStyle(
                  color: AppColors.primaryColor, 
                ),
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
              onPressed:() {
                if(textField.text.isNotEmpty) {
                  fetchCard(textField.text);
                }
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                )
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            if (cardImageUrl != null)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setImageUrlToNull();
                  },
                  child: Image.network(cardImageUrl!),
                ),
              )
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Magic Card Finder',
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
      elevation: 4.0, // Adds shadow to the AppBar itself
    );
  }

}
