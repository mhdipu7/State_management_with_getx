import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/model/task_list_wrapper_model.dart';
import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTasksInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getCancelledTasksInProgress => _getCancelledTasksInProgress;

  List<TaskModel> get cancelledTasks => _taskList;

  String get errorMessage => _errorMessage;

  Future<bool> getCancelledTasks() async {
    bool isSuccess = true;
    _getCancelledTasksInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.cancelledTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.reponseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get cancelled task failed! Try again.';
    }

    _getCancelledTasksInProgress = false;
    update();

    return isSuccess;
  }
}
