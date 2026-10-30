import '../models/flashcard.dart';

class FlashcardUtils {

  // Calculate total number of flashcards
  static int getTotalCards(List<Flashcard> cards) {
    return cards.length;
  }

  // Calculate number of studied cards
  static int getStudiedCards(Set<int> studiedIndexes) {
    return studiedIndexes.length;
  }

  // Calculate study progress
  static double getProgress(int total, int studied) {
    if (total == 0) {
      return 0;
    }

    return studied / total;
  }

  // Generate progress message
  static String getProgressMessage(int total, int studied) {

    if (total == 0) {
      return 'Create your first flashcard!';
    } else if (studied == 0) {
      return 'Start studying your flashcards!';
    } else if (studied == total) {
      return 'Great! You studied all your cards.';
    } else {
      return 'Keep going! You are making progress.';
    }
  }
}