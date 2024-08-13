import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class PinVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;
  String _errorMessage = '';

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> otpVerification({
    required String pinTEController,
    required VoidCallback onTapVerifyOTPButton,
    required VoidCallback pinVerificationSuccess,
  }) async {
    bool isSuccess = false;
    String? email = await AuthController.getVerificationEmail();

    _otpVerificationInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.otpVerification(
        email!,
        pinTEController,
      ),
    );

    if (response.isSuccess && response.reponseData['status']=='success') {
      onTapVerifyOTPButton();
      pinVerificationSuccess();
      await AuthController.saveVerificationOTP(
        pinTEController,
      );
    } else {
      _errorMessage =
          response.errorMessage ?? 'OTP verification failed! Try again.';
    }
    _otpVerificationInProgress = false;
    update();

    return isSuccess;
  }
}
