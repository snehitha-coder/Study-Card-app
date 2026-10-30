
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int total;
  final int studied;
  final double progress;
  final String message;

  const ProgressCard({
    super.key,
    required this.total,
    required this.studied,
    required this.progress,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Padding(
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
                Text('Flashcards: $total'),
                const SizedBox(height: 8),
                Text('Studied: $studied / $total'),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 10),
                Text('Progress: ${(progress * 100).round()}%'),
                const SizedBox(height: 8),
                Text(message),
              ],
            ),
          ),

          // Positioned badge using Stack
          Positioned(
            top: 15,
            right: 15,
            child: Icon(
              Icons.auto_graph,
              color: Colors.indigo,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
