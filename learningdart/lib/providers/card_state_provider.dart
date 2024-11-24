import 'package:flutter/material.dart';
import 'package:learningdart/models/card_model.dart';
import 'package:learningdart/utils/card_fetcher_functions.dart';

class CardStateProvider with ChangeNotifier {
  List<CardModel> _cards = [];
  bool _isLoading = false;

  List<CardModel> get cards => _cards;
  bool get isLoading => _isLoading;

  Future<void> fetchCards(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final rawData = await fetchCardData(userId);
      print('Raw data fetched: $rawData'); // Debug log

      _cards = rawData.map((json) => CardModel.fromJson(json)).toList();
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}