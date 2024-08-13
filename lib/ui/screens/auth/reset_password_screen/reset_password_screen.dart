import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/reset_password_controller.dart';
import 'package:task_manager_app/ui/screens/auth/reset_password_screen/reset_password_footer.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/background_widgets.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String matchPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundWidgets(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      "Set Password",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Minimum length of password should be mora than 6 letters and combination of numbers and letters.",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: _showPassword == false,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showPassword = !_showPassword;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your password";
                        } else if (value!.length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      obscureText: _showConfirmPassword == false,
                      decoration: InputDecoration(
                        hintText: "Confirm password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showConfirmPassword = !_showConfirmPassword;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            _showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your password";
                        } else if (value!.length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<ResetPasswordController>(
                      builder: (resetPasswordController) {
                        return Visibility(
                          visible:
                              resetPasswordController.resetPasswordInProgress ==
                                  false,
                          replacement: const CenterdProgressIndicator(),
                          child: GetBuilder<ResetPasswordController>(
                            builder: (resetPasswordController) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_confirmPasswordTEController.text ==
                                        _passwordTEController.text) {
                                      resetPasswordController.resetPassword(
                                        onTapConfirmButton: _onTapConfirmButton,
                                        password: _passwordTEController.text,
                                        passwordResetSuccess:
                                            _passwordResetSuccess,
                                        verificationDataNotFound:
                                            _verificationDataNotFound,
                                      );
                                    } else {
                                      snackBarMessage(
                                        context,
                                        "Password did't match. Try again!",
                                        true,
                                      );
                                    }
                                  }
                                },
                                child: const Text("Confirm"),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 36),
                    resetPasswordFooter(
                      onTapSingInButton: _onTapSingInButton
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  void _onTapSingInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (route) => false,
    );
  }

  void _passwordResetSuccess() {
    if (mounted) {
      snackBarMessage(
        context,
        "Password successfully reset & updated",
      );
    }
  }

  void _verificationDataNotFound() {
    if (mounted) {
      snackBarMessage(
        context,
        "Verification data not found. Please try again.",
        true,
      );
    }
  }

  void _onTapConfirmButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
