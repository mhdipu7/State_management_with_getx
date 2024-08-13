import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/new_task_controller.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen/add_new_task_screen.dart';
import 'package:task_manager_app/ui/screens/new_task_screen/custom_summary_section.dart';
import 'package:task_manager_app/ui/utility/app_colors.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/centered_empty_lottie.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<NewTaskController>().getTaskCountByStatus();
    Get.find<NewTaskController>().getNewTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSummarySection(),
            const SizedBox(height: 8),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _initialCall();
                },
                child: GetBuilder<NewTaskController>(
                  builder: (newTaskController) {
                    return Visibility(
                      visible: newTaskController.getNewTasksInProgress == false,
                      replacement: const CenterdProgressIndicator(),
                      child: Visibility(
                        visible: newTaskController.newTaskList.isNotEmpty,
                        replacement: const SingleChildScrollView(
                          child: CenteredEmptyLottie(),
                        ),
                        child: ListView.builder(
                          itemCount: newTaskController.newTaskList.length,
                          itemBuilder: (context, index) {
                            return TaskItem(
                              taskModel: newTaskController.newTaskList[index],
                              onUpdateTask: _initialCall,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        foregroundColor: AppColors.white,
        onPressed: _onTapAddButton,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  void _onTapAddButton() {
    Get.to(() => const AddNewTaskScreen());
  }
}
