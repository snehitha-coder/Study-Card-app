
class StudyResource {
  final int userId;
  final int id;
  final String title;
  final String body;

  StudyResource({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory StudyResource.fromJson(Map<String, dynamic> json) {
    return StudyResource(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
