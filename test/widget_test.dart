
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:studycardapp/main.dart';
import 'package:studycardapp/providers/flashcard_provider.dart';

void main() {
  testWidgets('Study Card app loads successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => FlashcardProvider(),
        child: const StudyCardApp(),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
