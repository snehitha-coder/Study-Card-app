
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl =
      'https://jsonplaceholder.typicode.com/posts';

  Future<String> fetchResources() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load study resources');
    }
  }
}
