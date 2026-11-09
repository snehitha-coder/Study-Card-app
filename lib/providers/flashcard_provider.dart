import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardProvider extends ChangeNotifier {
  // Store all flashcards
  final List<Flashcard> _cards = [
    Flashcard(
      question: 'What is Flutter?',
      answer: 'A UI framework by Google.',
    ),
    Flashcard(
      question: 'What is Dart?',
      answer: 'The programming language used by Flutter.',
    ),
  ];

  // Store studied card indexes
  final Set<int> _studiedIndexes = {};

  // Access flashcards
  List<Flashcard> get cards => _cards;

  // Access studied indexes
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
