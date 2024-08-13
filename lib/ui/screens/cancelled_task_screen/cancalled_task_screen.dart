import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/centered_empty_lottie.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CancelledTaskController>().getCancelledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskController>(
        builder: (cancelledTaskController) {
          return Visibility(
            visible: cancelledTaskController.cancelledTasks.isNotEmpty,
            replacement: const SingleChildScrollView(
              child: CenteredEmptyLottie(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                cancelledTaskController.getCancelledTasks();
              },
              child: Visibility(
                visible: cancelledTaskController.getCancelledTasksInProgress ==
                    false,
                replacement: const CenterdProgressIndicator(),
                child: ListView.builder(
                  itemCount: cancelledTaskController.cancelledTasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: cancelledTaskController.cancelledTasks[index],
                      onUpdateTask: cancelledTaskController.getCancelledTasks,
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
