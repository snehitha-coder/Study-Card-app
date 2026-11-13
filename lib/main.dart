
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/flashcard.dart';
import 'add_card_page.dart';
import 'study_page.dart';
import 'widgets/progress_card.dart';
import 'utils/flashcard_utils.dart';
import 'providers/flashcard_provider.dart';

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
        scaffoldBackgroundColor: const Color(0xFFF7F5FC),
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

  Future<void> openAddCardPage(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      '/add-card',
    );

    if (!context.mounted) return;

    if (result == true) {
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
          content: Text('Please add a flashcard first.'),
        ),
      );
      return;
    }

    Navigator.pushNamed(context, '/study');
  }

  @override
  Widget build(BuildContext context) {
    // Get shared flashcard data from Provider.
    final provider = context.watch<FlashcardProvider>();

    final cards = provider.cards;
    final studiedIndexes = provider.studiedIndexes;

    // Calculate progress.
    final totalCards = FlashcardUtils.getTotalCards(cards);

    final studiedCards =
        FlashcardUtils.getStudiedCards(studiedIndexes);

    final progress =
        FlashcardUtils.getProgress(totalCards, studiedCards);

    final message =
        FlashcardUtils.getProgressMessage(totalCards, studiedCards);

    // Responsive screen configuration.
    final screenWidth = MediaQuery.of(context).size.width;

    double horizontalPadding = 20;

    if (screenWidth > 900) {
      horizontalPadding = 100;
    } else if (screenWidth > 600) {
      horizontalPadding = 50;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StudyCard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dashboard heading.
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, Student!',
                            style: TextStyle(
                              fontSize:
                                  screenWidth > 600 ? 30 : 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Ready to learn something new?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: screenWidth > 600 ? 30 : 24,
                      backgroundColor: Colors.deepPurple.shade100,
                      child: const Icon(
                        Icons.school,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Progress Card.
                ProgressCard(
                  total: totalCards,
                  studied: studiedCards,
                  progress: progress,
                  message: message,
                ),

                const SizedBox(height: 30),

                const Text(
                  'Your Learning Space',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // Create Card button.
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => openAddCardPage(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Card'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Study Now button.
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        openStudyPage(context, totalCards),
                    icon: const Icon(Icons.menu_book),
                    label: const Text('Study Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  'Total Flashcards: ${cards.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
