import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchManaSymbols() async {
  final response = await http.get(Uri.parse('https://api.scryfall.com/symbology'));

  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data'];
    print('Fetched Symbols: $data');
    return {
      for (var symbol in data)
        if (symbol['svg_uri'] != null) symbol['symbol']: symbol['svg_uri']
    };
  } else {
    throw Exception('Failed to fetch mana symbols');
  }
}