import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/completed_task_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/centered_empty_lottie.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CompletedTaskController>().getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskController>(
        builder: (completedTaskController) {
          return Visibility(
            visible: completedTaskController.completedTasks.isNotEmpty,
            replacement: const SingleChildScrollView(
              child: CenteredEmptyLottie(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                completedTaskController.getCompletedTasks();
              },
              child: Visibility(
                visible: completedTaskController.getCompletedTasksInProgress ==
                    false,
                replacement: const CenterdProgressIndicator(),
                child: ListView.builder(
                  itemCount: completedTaskController.completedTasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: completedTaskController.completedTasks[index],
                      onUpdateTask: completedTaskController.getCompletedTasks,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
