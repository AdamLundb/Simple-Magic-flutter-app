class CardModel {
  final String name;
  final String manaCost;
  final int quantity;
  final String setName;
  final bool isFoil;

  CardModel({
    required this.name,
    required this.manaCost,
    required this.quantity,
    required this.setName,
    required this.isFoil,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['card_name'],
      manaCost: json['card_mana'],
      quantity: json['quantity'],
      setName: json['set_name'],
      isFoil: json['is_foil'] == 1,
    );
  }
}