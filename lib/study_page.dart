
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

  void nextCard(int totalCards) {
    if (totalCards == 0) return;

    setState(() {
      currentIndex = (currentIndex + 1) % totalCards;
      showAnswer = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Moving to card ${currentIndex + 1}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void flipCard() {
    final provider = context.read<FlashcardProvider>();

    if (!showAnswer) {
      final alreadyStudied =
          provider.studiedIndexes.contains(currentIndex);

      provider.markCardStudied(currentIndex);

      if (!alreadyStudied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Card marked as studied!'),
            duration: Duration(seconds: 1),
          ),
        );

        if (provider.studiedCards == provider.totalCards) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Congratulations! All cards completed!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }

    setState(() {
      showAnswer = !showAnswer;
    });
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FlashcardProvider>();
    final cards = provider.cards;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Mode'),
        centerTitle: true,
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
                  Text(
                    'Card ${currentIndex + 1} of ${cards.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 25),

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
