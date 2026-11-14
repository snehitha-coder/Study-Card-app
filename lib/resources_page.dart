
import 'package:flutter/material.dart';
import 'utils/api_service.dart';
import 'models/study_resource.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({super.key});

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  late Future<List<StudyResource>> resourcesFuture;

  @override
  void initState() {
    super.initState();
    resourcesFuture = ApiService().fetchResources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Resources'),
      ),
      body: FutureBuilder<List<StudyResource>>(
        future: resourcesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No resources available'),
            );
          }

          final resources = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              'Total Resources: ${resources.length}\n\n' +
              resources.map((resource) {
                return 'ID: ${resource.id}\n'
                    'User ID: ${resource.userId}\n'
                    'Title: ${resource.title}\n'
                    'Body: ${resource.body}';
              }).join('\n\n-------------------\n\n'),
            ),
          );
        },
      ),
    );
  }
}
