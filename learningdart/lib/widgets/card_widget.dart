import 'package:flutter/material.dart';
import 'package:learningdart/widgets/mana_symbol_widget.dart';

class CardModel {
  final String name;
  final String manaCost;
  final int quantity;
  final Color color;

  CardModel({
    required this.name,
    required this.manaCost,
    required this.quantity,
    required this.color,
  });
}

class CardWidget extends StatelessWidget {
  final CardModel card;
  final bool isSelected;
  final VoidCallback onTap;
  final Map<String, String> manaSymbolUrls;

  CardWidget({
    required this.card,
    required this.isSelected,
    required this.onTap,
    required this.manaSymbolUrls,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedAlign(
        duration: Duration(milliseconds: 300),
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isSelected ? 100 : 60,
          width: isSelected
              ? MediaQuery.of(context).size.width * 0.85
              : MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: card.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: buildManaCostImages(card.manaCost, manaSymbolUrls),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    card.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSelected ? 22 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'x${card.quantity}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isSelected ? 18 : 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}