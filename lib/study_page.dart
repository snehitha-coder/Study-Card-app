import 'package:flutter/material.dart';
import 'models/flashcard.dart';

class StudyPage extends StatefulWidget {
  final List<Flashcard> cards;

  const StudyPage({
    super.key,
    required this.cards,
  });

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  int currentIndex = 0;
  bool showAnswer = false;

  void nextCard() {
    setState(() {
      currentIndex =
          (currentIndex + 1) % widget.cards.length;
      showAnswer = false;
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

            Text(
              'Card ${currentIndex + 1} of ${widget.cards.length}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            GestureDetector(
              onTap: () {
                setState(() {
                  showAnswer = !showAnswer;
                });
              },

              child: Card(
                elevation: 4,

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),

                  child: Column(
                    children: [

                      Text(
                        showAnswer
                            ? 'Answer'
                            : 'Question',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

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
                onPressed: nextCard,

                child: const Text(
                  'Next Card',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}