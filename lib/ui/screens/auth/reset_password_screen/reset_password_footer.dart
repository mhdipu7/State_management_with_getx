import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/utility/app_colors.dart';

Widget resetPasswordFooter(
{
  required VoidCallback onTapSingInButton,
}
    ) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4),
        text: "Have an account? ",
        children: [
          TextSpan(
            style:
            const TextStyle(color: AppColors.themeColor),
            text: "Sign In",
            recognizer: TapGestureRecognizer()
              ..onTap = onTapSingInButton,
          ),
        ],
      ),
    ),
  );
}