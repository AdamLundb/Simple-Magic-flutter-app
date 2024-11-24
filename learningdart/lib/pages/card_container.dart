import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learningdart/widgets/card_widget.dart';
import 'package:learningdart/providers/card_state_provider.dart';

class CardList extends StatefulWidget {
  final Map<String, String> manaSymbolUrls;

  const CardList({
    Key? key,
    required this.manaSymbolUrls,
  }) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    final cardState = Provider.of<CardStateProvider>(context);
    print('CardList received cards: ${cardState.cards}'); // Debug log

    if (cardState.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (cardState.cards.isEmpty) {
      return Center(child: Text('No cards found.'));
    }

    return ListView.builder(
      itemCount: cardState.cards.length,
      itemBuilder: (context, index) {
        return CardWidget(
          card: cardState.cards[index],
          isSelected: selectedCardIndex == index, // Check if this card is selected
          onTap: () {
            setState(() {
              // Toggle the selected card
              selectedCardIndex = (selectedCardIndex == index) ? null : index;
            });
          },
          manaSymbolUrls: widget.manaSymbolUrls,
        );
      },
    );
  }
}