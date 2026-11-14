
import 'package:flutter/material.dart';
import 'utils/api_service.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({super.key});

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  late Future<String> resourcesFuture;

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
      body: FutureBuilder<String>(
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SelectableText(snapshot.data ?? 'No data available'),
          );
        },
      ),
    );
  }
}
