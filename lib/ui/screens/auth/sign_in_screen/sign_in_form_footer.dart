import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/utility/app_colors.dart';

Widget signInFormFooter(
{
  required VoidCallback onTapForgotPasswordButton,
  required VoidCallback onTapSingUpButton,
}
) {
  return Center(
    child: Column(
      children: [
        TextButton(
          onPressed: onTapForgotPasswordButton,
          child: const Text("Forgot Password?"),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4),
            text: "Don't have an account? ",
            children: [
              TextSpan(
                style: const TextStyle(color: AppColors.themeColor),
                text: "Sign Up",
                recognizer: TapGestureRecognizer()..onTap = onTapSingUpButton,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
