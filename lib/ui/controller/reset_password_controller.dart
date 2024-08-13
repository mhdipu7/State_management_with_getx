import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;
  String _errorMessage = '';

  bool get resetPasswordInProgress => _resetPasswordInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> resetPassword({
    required VoidCallback onTapConfirmButton,
    required String password,
    required VoidCallback passwordResetSuccess,
    required VoidCallback verificationDataNotFound,
  }) async {
    bool isSuccess = false;
    _resetPasswordInProgress = true;
    update();

    String? email = await AuthController.getVerificationEmail();
    String? otp = await AuthController.getVerificationOTP();

    if (email == null || otp == null) {
      verificationDataNotFound();
      _resetPasswordInProgress = false;
      update();
    }

    Map<String, dynamic> requestInput = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.recoverResetPass,
      body: requestInput,
    );

    if (response.isSuccess) {
      passwordResetSuccess();
      onTapConfirmButton();
    } else {
      _errorMessage =
          response.errorMessage ?? 'Password reset failed! Try again.';
    }

    _resetPasswordInProgress = false;
    update();

    return isSuccess;
  }
}
