// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  final int id;
  final String userId; // Novo campo -> Id do usuário no firebase
  final String description;
  final DateTime dateTime;
  final bool finished;

  TaskModel({
    required this.id,
    required this.userId, // Novo campo -> Id do usuário no firebase
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  factory TaskModel.loadFromDb(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      userId: task['userId'], // Novo campo -> Id do usuário no firebase
      description: task['description'],
      dateTime: DateTime.parse(task['data_hora']),
      finished: task['finalizado'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId, // Novo campo -> Id do usuário no firebase
      'description': description,
      'data_hora': dateTime.toIso8601String(),
      'finalizado': finished ? 1 : 0,
    };
  }

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? finished,
    String? userId = '', // Novo campo -> Id do usuário no firebase
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId, // Novo campo -> Id do usuário no firebase
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      finished: finished ?? this.finished,
    );
  }
}
