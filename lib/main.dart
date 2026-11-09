
import 'package:flutter/material.dart';
import 'models/flashcard.dart';
import 'add_card_page.dart';
import 'study_page.dart';
import 'utils/flashcard_utils.dart';
import 'widgets/progress_card.dart';

void main() {
  runApp(const StudyCardApp());
}

// Arguments passed to the Study Page
class StudyRouteArguments {
  final List<Flashcard> cards;
  final Function(int) onCardStudied;

  StudyRouteArguments({
    required this.cards,
    required this.onCardStudied,
  });
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

      // Named application routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),

        '/add-card': (context) => const AddCardPage(),

        '/study': (context) {
          final args = ModalRoute.of(context)!
              .settings
              .arguments as StudyRouteArguments;

          return StudyPage(
            cards: args.cards,
            onCardStudied: args.onCardStudied,
          );
        },
      },
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

  Set<int> studiedIndexes = {};

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

    // Get screen dimensions using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define screen breakpoints
    final isTablet = screenWidth >= 600;
    final isLargeScreen = screenWidth >= 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Card'),
        centerTitle: true,
      ),

      // Responsive dashboard
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isLargeScreen ? 900 : 800,
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    isTablet ? 32 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight < 600 ? 10 : 20,
                      ),

                      // Dashboard heading
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Study Smarter',
                              style: TextStyle(
                                fontSize: isTablet ? 36 : 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: isTablet ? 28 : 24,
                            child: const Icon(Icons.school),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Create flashcards and revise your subjects easily.',
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(height: isTablet ? 40 : 30),

                      // Progress widget
                      ProgressCard(
                        total: total,
                        studied: studied,
                        progress: progress,
                        message: message,
                      ),

                      SizedBox(height: isTablet ? 40 : 30),

                      // Create Card using named route
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final newCard =
                                await Navigator.pushNamed<Flashcard>(
                              context,
                              '/add-card',
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

                      // Study Now using named route
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            if (cards.isEmpty) {
                              return;
                            }

                            Navigator.pushNamed(
                              context,
                              '/study',
                              arguments: StudyRouteArguments(
                                cards: cards,
                                onCardStudied: markCardStudied,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
