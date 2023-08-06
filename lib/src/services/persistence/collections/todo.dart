import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id isarId = Isar.autoIncrement;
  String? title;
  int? category;
  String? description;
  DateTime? createdAt;
  DateTime? deadline;

  Todo({
    this.title,
    this.category,
    this.description,
    this.createdAt,
    this.deadline,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String?,
      category: json['category'] as int?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as DateTime?,
      deadline: json['deadline'] as DateTime?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'created_at': createdAt,
      'deadline': deadline,
    };
  }
}
