
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/flashcard_provider.dart';
import 'add_card_page.dart';
import 'study_page.dart';
import 'resources_page.dart';
import 'widgets/progress_card.dart';
import 'utils/app_theme.dart';

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
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.themeMode,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'StudyCard',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentTheme,

          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/add-card': (context) => const AddCardPage(),
            '/study': (context) => const StudyPage(),
            '/resources': (context) => const ResourcesPage(),
          },
        );
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

    final totalCards = provider.totalCards;
    final studiedCards = provider.studiedCards;
    final remainingCards = provider.remainingCards;
    final progress = provider.progress;

    // Responsive layout
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
        actions: [
          IconButton(
            tooltip: AppTheme.themeMode.value == ThemeMode.light
                ? 'Switch to Dark Mode'
                : 'Switch to Light Mode',
            onPressed: AppTheme.toggleTheme,
            icon: Icon(
              AppTheme.themeMode.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
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

                // Progress card
                ProgressCard(
                  total: totalCards,
                  studied: studiedCards,
                  progress: progress,
                  message: progressMessage,
                ),

                const SizedBox(height: 20),

                // Remaining cards
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pending_actions,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Create flashcard
                ElevatedButton.icon(
                  onPressed: () => openAddCardPage(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Create Flashcard'),
                ),

                const SizedBox(height: 15),

                // Study button
                ElevatedButton.icon(
                  onPressed: () =>
                      openStudyPage(context, totalCards),
                  icon: const Icon(Icons.school),
                  label: const Text('Study Now'),
                ),

                const SizedBox(height: 15),

                // Study Resources button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/resources');
                  },
                  icon: const Icon(Icons.library_books),
                  label: const Text('Study Resources'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
