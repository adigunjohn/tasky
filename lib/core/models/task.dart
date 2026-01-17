import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: 3)
class Task {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool completed;
  @HiveField(4)
  final DateTime? createdAt;
  @HiveField(5)
  final DateTime? updatedAt;
  @HiveField(6)
  final int userId;

  Task({
    required this.title,
    this.id,
    required this.description,
    required this.completed,
    this.createdAt,
    this.updatedAt,
    required this.userId,
});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      // 'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'user_id': userId,
    };
  }

    factory Task.fromJson(Map<String, dynamic> json) {
      return Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        completed: json['completed'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
        updatedAt: json['updated_at'] != null ? DateTime.fromMillisecondsSinceEpoch(json['updated_at']) : null,
        userId: json['user_id'],
          );
    }

  @override
  String toString() {
    return 'Task(title: $title, description: $description, completed: $completed, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }

}