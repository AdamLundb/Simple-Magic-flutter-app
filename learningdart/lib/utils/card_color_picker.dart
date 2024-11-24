String chooseColorImage(String input) {
  const colorImages = {
    "blue": "assets/cardbackground/blueBackground.png",
    "black": "assets/cardbackground/blackBackground.png",
    "white": "assets/cardbackground/whiteBackground.png",
    "green": "assets/cardbackground/greenBackground.png",
    "red": "assets/cardbackground/redBackground.png",
    "multicolor": "assets/cardbackground/multiColoredBackground.png",
    "colorless": "assets/cardbackground/colorlessBackground.png",
  };

  final letters = RegExp(r'[UBWGR]').allMatches(input).map((match) => match.group(0)).toSet();

  if (letters.isEmpty) {
    return colorImages["colorless"]!; 
  } else if (letters.length == 1) {
    switch (letters.first) {
      case 'U':
        return colorImages["blue"]!;
      case 'B':
        return colorImages["black"]!;
      case 'W':
        return colorImages["white"]!;
      case 'G':
        return colorImages["green"]!;
      case 'R':
        return colorImages["red"]!;
      default:
        return colorImages["colorless"]!; 
    }
  } else {
    return colorImages["multicolor"]!; 
  }
}