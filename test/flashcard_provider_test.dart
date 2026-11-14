
import 'package:flutter_test/flutter_test.dart';
import 'package:studycardapp/providers/flashcard_provider.dart';
import 'package:studycardapp/models/flashcard.dart';

void main() {
  late FlashcardProvider provider;

  setUp(() {
    provider = FlashcardProvider();
  });

  test('Initial flashcard count should be 2', () {
    expect(provider.totalCards, 2);
    expect(provider.studiedCards, 0);
    expect(provider.remainingCards, 2);
  });

  test('Add flashcard successfully', () {
    final card = Flashcard(
      question: 'What is Java?',
      answer: 'Java is a programming language.',
    );

    provider.addCard(card);

    expect(provider.totalCards, 3);
  });

  test('Mark flashcard as studied', () {
    provider.markCardStudied(0);

    expect(provider.studiedCards, 1);
    expect(provider.remainingCards, 1);
  });

  test('Do not count the same card twice', () {
    provider.markCardStudied(0);
    provider.markCardStudied(0);

    expect(provider.studiedCards, 1);
  });

  test('Progress should be calculated correctly', () {
    provider.markCardStudied(0);

    expect(provider.progress, 0.5);
  });

  test('Invalid index should not change progress', () {
    provider.markCardStudied(10);

    expect(provider.studiedCards, 0);
    expect(provider.progress, 0.0);
  });
}
