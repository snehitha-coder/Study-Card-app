
import 'package:flutter/material.dart';
import 'models/flashcard.dart';
import 'add_card_page.dart';
import 'study_page.dart';
import 'utils/flashcard_utils.dart';
import 'widgets/progress_card.dart';

void main() {
  runApp(const StudyCardApp());
}

class StudyCardApp extends StatelessWidget {
  const StudyCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Flashcard> cards = [
    Flashcard(
      question: 'What is Flutter?',
      answer: 'A UI framework by Google.',
    ),
    Flashcard(
      question: 'What is Dart?',
      answer: 'The programming language used by Flutter.',
    ),
  ];

  // Store indexes of studied cards
  Set<int> studiedIndexes = {};

  // Mark a card as studied
  void markCardStudied(int index) {
    setState(() {
      studiedIndexes.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    final total = FlashcardUtils.getTotalCards(cards);

    final studied =
        FlashcardUtils.getStudiedCards(studiedIndexes);

    final progress =
        FlashcardUtils.getProgress(total, studied);

    final message =
        FlashcardUtils.getProgressMessage(total, studied);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Card'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            const Text(
              'Study Smarter',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Create flashcards and revise your subjects easily.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            ProgressCard(
              total: total,
              studied: studied,
              progress: progress,
              message: message,
              ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {

                  final newCard = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCardPage(),
                    ),
                  );

                  if (newCard != null) {
                    setState(() {
                      cards.add(newCard);
                    });
                  }
                },

                icon: const Icon(Icons.add),
                label: const Text('Create Card'),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {

                  if (cards.isEmpty) {
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudyPage(
                        cards: cards,
                        onCardStudied: markCardStudied,
                      ),
                    ),
                  );
                },

                icon: const Icon(Icons.school),
                label: const Text('Study Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
