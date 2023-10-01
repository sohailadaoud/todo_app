class Task {
  static const String collectionName = 'tasks';

  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
      id: data['id'],
      title: data['title'],
      dateTime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
      description: data['description'],
      isDone: data['isDone']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.microsecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
