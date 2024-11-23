import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> buildManaCostImages(String manaCost, Map<String, String> manaSymbolUrls) {
  final symbolRegex = RegExp(r'{.*?}');
  final symbols = symbolRegex.allMatches(manaCost).map((m) => m.group(0)!);

  return symbols.map((symbol) {
    final imageUrl = manaSymbolUrls[symbol] ?? '';
    return imageUrl.isNotEmpty
        ? SvgPicture.network(
            imageUrl,
            width: 24,
            height: 24,
            placeholderBuilder: (context) => CircularProgressIndicator(
              strokeWidth: 1,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          )
        : Text(
            symbol,
            style: TextStyle(color: Colors.white),
          );
  }).toList();
}