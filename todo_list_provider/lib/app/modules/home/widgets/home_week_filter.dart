import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

import '../../../models/task_filter_enum.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
        (controller) => controller.filterSelected == TaskFilterEnum.week,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Dia da Semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: 95,
              child: Selector<HomeController, DateTime>(
                selector: (context, controller) =>
                    controller.initialDateOfWeek ?? DateTime.now(),
                builder: (_, value, __) {
                  return DatePicker(
                    value,
                    locale: 'pt_BR',
                    initialSelectedDate: value,
                    selectionColor: Colors.blue,
                    selectedTextColor: Colors.white,
                    daysCount: 7,
                    onDateChange: (date) {
                      context.read<HomeController>().filterByDay(date);
                    },
                  );
                },
              ))
        ],
      ),
    );
  }
}
