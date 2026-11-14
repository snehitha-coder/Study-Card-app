
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/study_resource.dart';

class ApiService {
  static const String apiUrl =
      'https://jsonplaceholder.typicode.com/posts';

  Future<List<StudyResource>> fetchResources() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData
          .map((item) => StudyResource.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load study resources');
    }
  }
}
