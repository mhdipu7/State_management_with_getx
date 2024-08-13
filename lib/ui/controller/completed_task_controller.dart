import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/model/task_list_wrapper_model.dart';
import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTasksInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getCompletedTasksInProgress => _getCompletedTasksInProgress;

  List<TaskModel> get completedTasks => _taskList;

  String get errorMessage => _errorMessage;

  Future<bool> getCompletedTasks() async {
    bool isSuccess = false;
    _getCompletedTasksInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.reponseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get completed task failed! Try again.';
    }

    _getCompletedTasksInProgress = false;
    update();

    return isSuccess;
  }
}
