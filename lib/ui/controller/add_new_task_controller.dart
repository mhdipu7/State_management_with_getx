import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';

class AddNewTaskController extends GetxController {
  bool _addNewTaskInProgress = false;
  String _errorMessage = '';

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> addNewTask(
      String title, String description, VoidCallback clearTextFields) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();

    Map<String, dynamic> requestInput = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createTask, body: requestInput);

    if (response.isSuccess) {
      clearTextFields();
    } else {
      _errorMessage =
          response.errorMessage ?? 'Add new task failed! Try again.';
    }

    _addNewTaskInProgress = false;
    update();

    return isSuccess;
  }
}
