
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:studycardapp/main.dart';
import 'package:studycardapp/providers/flashcard_provider.dart';

void main() {
  testWidgets('Create Flashcard button opens the form',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => FlashcardProvider(),
        child: const StudyCardApp(),
      ),
    );

    await tester.tap(find.text('Create Flashcard'));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('User can enter question and answer',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => FlashcardProvider(),
        child: const StudyCardApp(),
      ),
    );

    await tester.tap(find.text('Create Flashcard'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'What is Flutter?');
    await tester.enterText(fields.at(1), 'Flutter is a UI framework.');

    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('Flutter is a UI framework.'), findsOneWidget);
  });
}
