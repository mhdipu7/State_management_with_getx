import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class EmailVerificationController extends GetxController {
  bool _verifyEmailInProgress = false;
  String _errorMessage = '';

  bool get verifyEmailInProgress => _verifyEmailInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> verificationEmail({
    required String email,
    required VoidCallback onTapConfirmButton,
  }) async {
    bool isSuccess = false;
    _verifyEmailInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.recoverVerifyEmail(email),
    );

    _verifyEmailInProgress = false;
    update();

    if (response.isSuccess) {
      onTapConfirmButton();

      await AuthController.saveVerificationEmail(
        email,
      );
    } else {
      _errorMessage =
          response.errorMessage ?? 'Email verify failed!. Try again.';
    }
    return isSuccess;
  }
}
