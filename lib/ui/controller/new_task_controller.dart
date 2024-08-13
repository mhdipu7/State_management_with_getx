import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/model/task_count_by_status_model.dart';
import 'package:task_manager_app/data/model/task_count_by_status_wrapper_model.dart';
import 'package:task_manager_app/data/model/task_list_wrapper_model.dart';
import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTasksInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getNewTasksInProgress => _getNewTasksInProgress;

  List<TaskModel> get newTaskList => _taskList;

  String get errorMessage => _errorMessage;

  Future<bool> getNewTasks() async {
    bool isSuccess = false;
    _getNewTasksInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.newTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.reponseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage = response.errorMessage ?? 'Get new task failed! Try again';
    }

    _getNewTasksInProgress = false;
    update();
    return isSuccess;
  }





  bool _getTaskCountByStatusInProgress = false;
  List<TaskCountByStatusModel> _taskCountStatusList = [];
  String _errorMessageForTaskStatusCount = '';

  bool get getTaskCountByStatusInProgress => _getTaskCountByStatusInProgress;

  List<TaskCountByStatusModel> get taskCountStatusList => _taskCountStatusList;

  String get errorMessageForTaskStatusCount => _errorMessageForTaskStatusCount;

  Future<bool> getTaskCountByStatus() async {
    bool isSuccess = false;
    _getTaskCountByStatusInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.reponseData);
      _taskCountStatusList =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      _errorMessageForTaskStatusCount =
          response.errorMessage ?? 'Get Task Status Count failed! Try again.';
    }

    _getTaskCountByStatusInProgress = false;
    update();

    return isSuccess;
  }
}
