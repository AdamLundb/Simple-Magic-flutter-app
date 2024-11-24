import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learningdart/components.dart';
import 'package:learningdart/pages/card_container.dart';
import 'package:learningdart/utils/symbol_fetcher.dart';
import 'package:learningdart/providers/card_state_provider.dart';
import 'package:learningdart/providers/login_state_provider.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, String>> manaSymbolUrlsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch mana symbols when the widget initializes
    manaSymbolUrlsFuture = fetchManaSymbols();

    // Fetch cards when the profile page initializes
    final userId = Provider.of<LoginStateProvider>(context, listen: false).userId!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CardStateProvider>(context, listen: false).fetchCards(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Profile'),
      body: FutureBuilder<Map<String, String>>(
        future: manaSymbolUrlsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while waiting for the symbols
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show an error message if the fetch fails
            return Center(child: Text('Failed to load mana symbols'));
          } else {
            // Pass the fetched manaSymbolUrls to CardList
            return Consumer<CardStateProvider>(
              builder: (context, cardState, child) {
                return CardList(manaSymbolUrls: snapshot.data!);
              },
            );
          }
        },
      ),
    );
  }
}