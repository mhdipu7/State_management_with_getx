import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/utility/app_colors.dart';

Widget pinCodeTextField({
  required TextEditingController pinTEController,
  required BuildContext context,
}) {
  return PinCodeTextField(
    autoDisposeControllers: false,
    length: 6,
    obscureText: false,
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white),
    animationDuration: const Duration(milliseconds: 300),
    backgroundColor: Colors.transparent,
    keyboardType: TextInputType.number,
    enableActiveFill: true,
    controller: pinTEController,
    appContext: context,
  );
}
