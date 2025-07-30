
import 'package:firebase_auth/firebase_auth.dart'; // Adicione essa importação
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/task/task_create_controller.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

import '../../services/tasks/tasks_service_impl.dart';
import 'task_create_page.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
              create: (context) => TasksRepositoryImpl(
                auth: FirebaseAuth.instance, // Adicione o FirebaseAuth aqui
                connectionFactory: context.read(),
              ),
            ),
            Provider<TasksService>(
              create: (context) =>
                  TasksServiceImpl(tasksRepository: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  TaskCreateController(tasksService: context.read()),
            )
          ],
          routers: {
            '/task/create': (context) => TaskCreatePage(
                  controller: context.read(),
                ),
          },
        );
}
