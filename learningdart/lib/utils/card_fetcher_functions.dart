import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchCard(
    String cardName,
    Function(bool) setLoading,
    Function(String?) setCardImageUrl,
    Function(String) showErrorDialog,
    Function(String) setSetName,
) async {
  setLoading(true);
  try {
    final response = await http.get(Uri.parse('https://api.scryfall.com/cards/named?fuzzy=$cardName'));
    if (response.statusCode == 200) {
      final selectedCard = jsonDecode(response.body);
      setSetName(selectedCard['set']);
      setCardImageUrl(selectedCard['image_uris']['normal']);
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