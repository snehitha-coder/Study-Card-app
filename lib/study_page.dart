
import 'package:flutter/material.dart';
import 'models/flashcard.dart';

class StudyPage extends StatefulWidget {
  final List<Flashcard> cards;
  final Function(int) onCardStudied;

  const StudyPage({
    super.key,
    required this.cards,
    required this.onCardStudied,
  });

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  int currentIndex = 0;
  bool showAnswer = false;

  // Move to the next flashcard
  void nextCard() {
    setState(() {
      currentIndex =
          (currentIndex + 1) % widget.cards.length;
      showAnswer = false;
    });
  }

  // Flip the flashcard
  void flipCard() {
    if (!showAnswer) {
      widget.onCardStudied(currentIndex);
    }

    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.cards[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Mode'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card number
            Text(
              'Card ${currentIndex + 1} of ${widget.cards.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 25),

            // Flashcard
            GestureDetector(
              onTap: flipCard,
              child: Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),

                  child: Column(
                    children: [
                      // Icon changes according to card side
                      Icon(
                        showAnswer
                            ? Icons.lightbulb
                            : Icons.quiz,
                        size: 40,
                        color: Colors.indigo,
                      ),

                      const SizedBox(height: 15),

                      // Question or Answer heading
                      Text(
                        showAnswer ? 'Answer' : 'Question',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),

                      const Divider(height: 25),

                      // Flashcard content
                      Text(
                        showAnswer
                            ? card.answer
                            : card.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                        ),
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

            // Next Card button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: nextCard,
                child: const Text('Next Card'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
