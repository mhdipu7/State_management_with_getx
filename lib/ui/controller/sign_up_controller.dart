import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';

class SignUpController extends GetxController {
  bool _registrationInProgress = false;
  String _errorMessage = '';

  bool get registrationInProgress => _registrationInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> registerUser(
  {
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
    required VoidCallback clearTextFields,
    required VoidCallback onTapSingInButton,
    required VoidCallback registrationSuccess,
  }
  ) async {
    bool isSuccess = false;
    _registrationInProgress = true;
    update();

    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.registration,
      body: requestInput,
    );

    _registrationInProgress = false;
    update();

    if (response.isSuccess) {
      clearTextFields();
      onTapSingInButton();
      registrationSuccess();
    } else {
      _errorMessage =
          response.errorMessage ?? 'Registration failed! Try again.';
    }
    return isSuccess;
  }
}
