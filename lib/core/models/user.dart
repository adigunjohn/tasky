import 'package:hive_flutter/hive_flutter.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final int id;

  User({
    required this.name,
    required this.email,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, createdAt: $createdAt, id: $id)';
  }

}