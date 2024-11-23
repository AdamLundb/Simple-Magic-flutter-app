import 'package:flutter/material.dart';
import 'package:learningdart/widgets/card_widget.dart';

class CardList extends StatefulWidget {
  final Map<String, String> manaSymbolUrls;

  CardList({required this.manaSymbolUrls});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  int? selectedCardIndex;

  final List<CardModel> cards = [
    CardModel(
      name: "Divination",
      manaCost: "{2}{U}",
      quantity: 4,
      color: Colors.blue,
    ),
    CardModel(
      name: "Lightning Bolt",
      manaCost: "{R}",
      quantity: 2,
      color: Colors.red,
    ),
    CardModel(
      name: "Llanowar Elves",
      manaCost: "{G}",
      quantity: 3,
      color: Colors.green,
    ),
    CardModel(
      name: "Dark Ritual",
      manaCost: "{B}",
      quantity: 5,
      color: Colors.black,
    ),
    CardModel(
      name: "Wrath of God",
      manaCost: "{2}{W}{W}",
      quantity: 1,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardWidget(
          card: cards[index],
          isSelected: selectedCardIndex == index,
          onTap: () {
            setState(() {
              selectedCardIndex = selectedCardIndex == index ? null : index;
            });
          },
          manaSymbolUrls: widget.manaSymbolUrls, 
        );
      },
    );
  }
}