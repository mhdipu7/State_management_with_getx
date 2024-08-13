import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/centered_empty_lottie.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<InProgressTaskController>().getInProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InProgressTaskController>(
        builder: (inProgressNewTaskController) {
          return Visibility(
            visible: inProgressNewTaskController.inProgressTaskList.isNotEmpty,
            replacement: const SingleChildScrollView(
              child: CenteredEmptyLottie(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                inProgressNewTaskController.getInProgressTasks();
              },
              child: Visibility(
                visible:
                    inProgressNewTaskController.getInProgressTasksInProgress ==
                        false,
                replacement: const CenterdProgressIndicator(),
                child: ListView.builder(
                  itemCount:
                      inProgressNewTaskController.inProgressTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel:
                          inProgressNewTaskController.inProgressTaskList[index],
                      onUpdateTask:
                          inProgressNewTaskController.getInProgressTasks,
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
