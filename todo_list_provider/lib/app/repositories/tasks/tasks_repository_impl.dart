// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _connectionFactory;
  final FirebaseAuth _auth;

  TasksRepositoryImpl({
    required SqliteConnectionFactory connectionFactory,
    required FirebaseAuth auth,
  })  : _connectionFactory = connectionFactory,
        _auth = auth;

  // @override
  // Future<void> save(DateTime date, String description) async {
  //   final conn = await _connectionFactory.openConnection();
  //   await conn.insert('todo', {
  //     'id': null,
  //     'description': description,
  //     'data_hora': date.toIso8601String(),
  //     'finalizado': 0,
  //   });
  // }

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _connectionFactory.openConnection();
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    await conn.insert('todo', {
      'id': null,
      'description': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0,
      'userId': user.uid, // Adicionando o ID do usuário autenticado
    });
  }

  // @override
  // Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
  //   final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
  //   final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

  //   final conn = await _connectionFactory.openConnection();
  //   final result = await conn.rawQuery(
  //     '''
  //     SELECT *
  //     FROM todo
  //     WHERE data_hora BETWEEN ? AND ?
  //     ORDER BY data_hora
  //     ''',
  //     [startFilter.toIso8601String(), endFilter.toIso8601String()],
  //   );
  //   return result.map((t) => TaskModel.loadFromDb(t)).toList();
  // }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _connectionFactory.openConnection();
    final result = await conn.rawQuery(
      '''
      SELECT * 
      FROM todo 
      WHERE data_hora BETWEEN ? AND ? 
      AND userId = ? 
      ORDER BY data_hora
      ''',
      [startFilter.toIso8601String(), endFilter.toIso8601String(), user.uid],
    );
    return result.map((t) => TaskModel.loadFromDb(t)).toList();
  }

  // @override
  // Future<void> checkOrUnckedTask(TaskModel task) async {
  //   final conn = await _connectionFactory.openConnection();
  //   final finished = task.finished ? 1 : 0;
  //   await conn.rawUpdate(
  //     '''
  //     UPDATE todo
  //     SET finalizado = ?
  //     WHERE id = ?
  //     ''',
  //     [finished, task.id],
  //   );
  // }

  @override
  Future<void> checkOrUnckedTask(TaskModel task) async {
    final conn = await _connectionFactory.openConnection();
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    final finished = task.finished ? 1 : 0;
    await conn.rawUpdate(
      '''
      UPDATE todo 
      SET finalizado = ? 
      WHERE id = ? 
      AND userId = ?
      ''',
      [finished, task.id, user.uid],
    );
  }

  // @override
  // Future<void> deleteTask(int id) async {
  //   final conn = await _connectionFactory.openConnection();
  //   await conn.rawDelete(
  //     '''
  //     DELETE FROM todo
  //     WHERE id = ?
  //     ''',
  //     [id],
  //   );
  // }

  @override
  Future<void> deleteTask(int id) async {
    final conn = await _connectionFactory.openConnection();
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    await conn.rawDelete(
      '''
      DELETE FROM todo 
      WHERE id = ? 
      AND userId = ?
      ''',
      [id, user.uid],
    );
  }
}
