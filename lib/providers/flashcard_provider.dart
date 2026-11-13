
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

  // Get total number of flashcards
  int get totalCards => _cards.length;

  // Get number of studied flashcards
  int get studiedCards => _studiedIndexes.length;

  // Get number of remaining flashcards
  int get remainingCards => totalCards - studiedCards;

  // Get overall study progress
  double get progress {
    if (totalCards == 0) return 0.0;
    return studiedCards / totalCards;
  }

  // Add a new flashcard
  void addCard(Flashcard card) {
    _cards.add(card);
    notifyListeners();
  }

  // Mark a flashcard as studied
  void markCardStudied(int index) {
    if (index >= 0 && index < _cards.length) {
      if (_studiedIndexes.add(index)) {
        notifyListeners();
      }
    }
  }
}
