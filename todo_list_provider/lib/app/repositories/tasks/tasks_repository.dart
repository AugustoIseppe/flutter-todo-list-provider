import '../../models/task_model.dart';

abstract class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
  Future<void> checkOrUnckedTask(TaskModel task);
  Future<void> deleteTask(int id);
}
