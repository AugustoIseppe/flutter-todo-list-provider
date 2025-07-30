import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilterEnum;
  final TotalTasksModel? totalTasksModel;
  final bool selected;

  const TodoCardFilter({
    super.key,
    required this.label,
    required this.taskFilterEnum,
    this.totalTasksModel,
    required this.selected,
  });

  double _getPercentFinished() {
    final total = totalTasksModel?.totalTasks ?? 0;
    final totalFinished = totalTasksModel?.totalTasksFinished ?? 0;
    if (total == 0) {
      return 0;
    }
    final percent = (totalFinished / 100) * total;
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.read<HomeController>().findTasks(filter: taskFilterEnum),
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 120,
          maxWidth: 150,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected ? Colors.indigo : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              '${totalTasksModel?.totalTasks ?? 0} tasks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.grey[700],
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.grey[700],
              ),
            ),
            TweenAnimationBuilder(
              tween: Tween(
                begin: 0.0,
                end: _getPercentFinished(),
              ),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: selected ? Colors.white : Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(
                      selected ? Colors.white : Colors.blue[400]),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
