import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/new_task_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/task_summary_card.dart';

Widget customSummarySection() {
  return GetBuilder<NewTaskController>(
    builder: (newTaskController) {
      return Visibility(
        visible: newTaskController.getTaskCountByStatusInProgress == false,
        replacement: const CenterdProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: newTaskController.taskCountStatusList.map(
                  (e) {
                return TaskSummaryCard(
                  count: e.sum.toString(),
                  title: (e.sId ?? 'Unknown').toUpperCase(),
                );
              },
            ).toList(),
          ),
        ),
      );
    },
  );
}
