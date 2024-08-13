import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/model/task_list_wrapper_model.dart';
import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';

class InProgressTaskController extends GetxController {
  bool _getInProgressTasksInProgress = false;
  String _errorMessage = '';
  List<TaskModel> _taskList = [];

  bool get getInProgressTasksInProgress => _getInProgressTasksInProgress;

  String get errorMessage => _errorMessage;

  List<TaskModel> get inProgressTaskList => _taskList;

  Future<bool> getInProgressTasks() async {
    bool isSuccess = false;
    _getInProgressTasksInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.inProgressTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.reponseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get InProgress tasks failed! Try again.';
    }

    _getInProgressTasksInProgress = false;
    update();

    return isSuccess;
  }
}
