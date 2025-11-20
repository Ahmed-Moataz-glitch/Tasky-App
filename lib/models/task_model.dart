class TaskModel {
  static const String collection = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? date;
  int? priority;
  bool? isCompleted;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.priority,
    this.isCompleted = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json) : this(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    date: DateTime.fromMillisecondsSinceEpoch(json['date']),
    priority: json['priority'],
    isCompleted: json['isCompleted'] ?? false,
  );

  Map<String, dynamic> toJson() {
    final normalDate = DateTime(date!.year, date!.month, date!.day);
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': normalDate.millisecondsSinceEpoch,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }
}