import 'package:flutter/material.dart';
import 'models/flashcard.dart';
import 'add_card_page.dart';
import 'study_page.dart';

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

  // Flashcard data
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

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Your Progress',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Flashcards: ${cards.length}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Accuracy: 0%',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Create Card button
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

            // Study Now button
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