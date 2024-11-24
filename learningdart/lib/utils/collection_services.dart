import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addCardToCollection(int userId, String cardName, String setName, String cardMana, bool isFoil, int quantity) async {
  const String apiUrl = 'http://10.0.2.2:3000/api/collection';

  final Map<String, dynamic> requestBody = {
    'user_id': userId,
    'card_name': cardName,
    'set_name': setName,
    'card_mana' : cardMana,
    'is_foil': isFoil,
    'quantity': quantity,
  };

  try {
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Card added successfully: ${response.body}');
    } else {
      print('Failed to add card. Status code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  } catch (error) {
    print('Error occurred: $error');
  }
}