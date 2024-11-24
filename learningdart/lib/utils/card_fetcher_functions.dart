import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchCard(
    String cardName,
    Function(bool) setLoading,
    Function(String?) setCardImageUrl,
    Function(String) showErrorDialog,
    Function(String) setSetName,
    Function(String) setCardManaCost,
) async {
  setLoading(true);
  try {
    final response = await http.get(Uri.parse('https://api.scryfall.com/cards/named?fuzzy=$cardName'));
    if (response.statusCode == 200) {
      final selectedCard = jsonDecode(response.body);
      setSetName(selectedCard['set']);
      setCardImageUrl(selectedCard['image_uris']['normal']);
      setCardManaCost(selectedCard['mana_cost']);
    } else {
      setCardImageUrl(null);
      showErrorDialog("Couldn't get the card. Error code: ${response.statusCode}");
    }
  } catch (e) {
    setCardImageUrl(null);
    showErrorDialog("Couldn't get the card. Error: ${e.toString()}");
  } finally {
    setLoading(false);
  }
}

Future<List<dynamic>> fetchCardData(int userId) async {
  final url = Uri.parse('http://10.0.2.2:3000/api/collection/$userId');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("API Response: ${response.body}");
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cards');
    }
  } catch (error) {
    print('Error fetching cards: $error');
    throw error;
  }
}