
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/flashcard_provider.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  int currentIndex = 0;
  bool showAnswer = false;

  // Move to the next flashcard.
  void nextCard(int totalCards) {
    if (totalCards == 0) return;

    setState(() {
      currentIndex = (currentIndex + 1) % totalCards;
      showAnswer = false;
    });
  }

  // Flip the flashcard.
  void flipCard() {
    if (!showAnswer) {
      context
          .read<FlashcardProvider>()
          .markCardStudied(currentIndex);
    }

    setState(() {
      showAnswer = !showAnswer;
    });
  }

  // Return to dashboard.
  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Read shared flashcard data.
    final provider = context.watch<FlashcardProvider>();
    final cards = provider.cards;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Mode'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: goBack,
        ),
      ),
      body: cards.isEmpty
          ? const Center(
              child: Text('No flashcards available.'),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Card number.
                  Text(
                    'Card ${currentIndex + 1} of ${cards.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Flashcard.
                  GestureDetector(
                    onTap: flipCard,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Icon(
                              showAnswer
                                  ? Icons.lightbulb
                                  : Icons.quiz,
                              size: 40,
                              color: Colors.indigo,
                            ),

                            const SizedBox(height: 15),

                            Text(
                              showAnswer ? 'Answer' : 'Question',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),

                            const Divider(height: 25),

                            Text(
                              showAnswer
                                  ? cards[currentIndex].answer
                                  : cards[currentIndex].question,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 22),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Tap card to flip',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Next Card button.
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => nextCard(cards.length),
                      child: const Text('Next Card'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
