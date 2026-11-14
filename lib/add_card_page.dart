
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/flashcard.dart';
import 'providers/flashcard_provider.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController questionController =
      TextEditingController();

  final TextEditingController answerController =
      TextEditingController();

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  void clearForm() {
    _formKey.currentState?.reset();
    questionController.clear();
    answerController.clear();
  }

  void saveCard() {
    if (_formKey.currentState!.validate()) {
      final newCard = Flashcard(
        question: questionController.text.trim(),
        answer: answerController.text.trim(),
      );

      context.read<FlashcardProvider>().addCard(newCard);

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Flashcard'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.library_add,
                    size: 55,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    'Create a New Card',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller: questionController,
                    maxLength: 150,
                    decoration: InputDecoration(
                      labelText: 'Question',
                      hintText: 'Enter your question',
                      prefixIcon: const Icon(Icons.help_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a question';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: answerController,
                    maxLength: 500,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Answer',
                      hintText: 'Enter your answer',
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.lightbulb_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an answer';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: saveCard,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Flashcard'),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton.icon(
                    onPressed: clearForm,
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear Form'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
