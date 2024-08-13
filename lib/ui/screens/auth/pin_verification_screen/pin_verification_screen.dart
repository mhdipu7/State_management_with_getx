import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/pin_verification_controller.dart';
import 'package:task_manager_app/ui/screens/auth/pin_verification_screen/pin_code_text_field.dart';
import 'package:task_manager_app/ui/screens/auth/pin_verification_screen/pin_verification_footer.dart';
import 'package:task_manager_app/ui/screens/auth/reset_password_screen/reset_password_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/background_widgets.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundWidgets(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Pin Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "A 6 digits verification pin has been sent to your email address",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  pinCodeTextField(
                    pinTEController: _pinTEController,
                    context: context,
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<PinVerificationController>(
                    builder: (pinVerificationController) {
                      return Visibility(
                        visible: pinVerificationController
                                .otpVerificationInProgress ==
                            false,
                        replacement: const CenterdProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_pinTEController.text.trim().isNotEmpty) {
                              pinVerificationController.otpVerification(
                                pinTEController: _pinTEController.text.trim(),
                                onTapVerifyOTPButton: _onTapVerifyOTPButton,
                                pinVerificationSuccess: _pinVerificationSuccess,
                              );
                            }
                          },
                          child: const Text("Verify"),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 36),
                  pinVerificationFooter(onTapSignInButton: _onTapSignInButton)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pinVerificationSuccess() {
    if (mounted) {
      snackBarMessage(context, "Pin verification success.");
    }
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (route) => false,
    );
  }

  void _onTapVerifyOTPButton() {
    Get.to(() => const ResetPasswordScreen());
  }

  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
