
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/flashcard_provider.dart';
import 'add_card_page.dart';
import 'study_page.dart';
import 'widgets/progress_card.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FlashcardProvider(),
      child: const StudyCardApp(),
    ),
  );
}

class StudyCardApp extends StatelessWidget {
  const StudyCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyCard',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add-card': (context) => const AddCardPage(),
        '/study': (context) => const StudyPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openAddCardPage(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/add-card');

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Flashcard added successfully!'),
        ),
      );
    }
  }

  void openStudyPage(BuildContext context, int totalCards) {
    if (totalCards == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add flashcards first.'),
        ),
      );
      return;
    }

    Navigator.pushNamed(context, '/study');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FlashcardProvider>();

    // Get progress information from Provider.
    final totalCards = provider.totalCards;
    final studiedCards = provider.studiedCards;
    final remainingCards = provider.remainingCards;
    final progress = provider.progress;

    // Responsive screen configuration.
    final screenWidth = MediaQuery.of(context).size.width;

    double horizontalPadding = 20;

    if (screenWidth >= 900) {
      horizontalPadding = 100;
    } else if (screenWidth >= 600) {
      horizontalPadding = 50;
    }

    String progressMessage;

    if (totalCards == 0) {
      progressMessage = 'Start adding flashcards!';
    } else if (progress == 1.0) {
      progressMessage = 'All cards completed!';
    } else {
      progressMessage = 'Keep learning. You are making progress!';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyCard'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome to StudyCard!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Learn and revise using flashcards.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // Progress card.
                ProgressCard(
                  total: totalCards,
                  studied: studiedCards,
                  progress: progress,
                  message: progressMessage,
                ),

                const SizedBox(height: 20),

                // Remaining cards.
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pending_actions,
                          color: Colors.deepPurple,
                          size: 30,
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Text(
                            'Remaining Cards',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '$remainingCards',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Create Card button.
                ElevatedButton.icon(
                  onPressed: () => openAddCardPage(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Create Flashcard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),

                const SizedBox(height: 15),

                // Study Now button.
                ElevatedButton.icon(
                  onPressed: () =>
                      openStudyPage(context, totalCards),
                  icon: const Icon(Icons.school),
                  label: const Text('Study Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
