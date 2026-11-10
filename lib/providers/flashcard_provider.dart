
import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardProvider extends ChangeNotifier {
  final List<Flashcard> _cards = [
    Flashcard(
      question: 'What is Flutter?',
      answer: 'Flutter is a UI framework developed by Google.',
    ),
    Flashcard(
      question: 'What is Dart?',
      answer: 'Dart is the programming language used by Flutter.',
    ),
  ];

  final Set<int> _studiedIndexes = {};

  // Get all flashcards
  List<Flashcard> get cards => _cards;

  // Get studied card indexes
  Set<int> get studiedIndexes => _studiedIndexes;

  // Add a new flashcard
  void addCard(Flashcard card) {
    _cards.add(card);
    notifyListeners();
  }

  // Mark a flashcard as studied
  void markCardStudied(int index) {
    if (index >= 0 && index < _cards.length) {
      _studiedIndexes.add(index);
      notifyListeners();
    }
  }
}
