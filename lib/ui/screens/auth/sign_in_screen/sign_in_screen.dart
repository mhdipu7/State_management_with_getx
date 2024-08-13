import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/sign_in_controller.dart';
import 'package:task_manager_app/ui/screens/auth/email_verification_screen/email_verification_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen/sign_in_form_footer.dart';
import 'package:task_manager_app/ui/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:task_manager_app/ui/screens/bottom_nav_main_screen/bottom_nav_main_screen.dart';
import 'package:task_manager_app/ui/utility/app_constants.dart';
import 'package:task_manager_app/ui/widgets/background_widgets.dart';
import 'package:task_manager_app/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundWidgets(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      "Get Started With",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: "Email"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your email";
                        }

                        if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
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
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<SignInController>(
                      builder: (signInController) {
                        return Visibility(
                          visible:
                              signInController.signInAPIInProgress == false,
                          replacement: const CenterdProgressIndicator(),
                          child: ElevatedButton(
                            onPressed: _onTapNextButton,
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 36),
                    signInFormFooter(
                      onTapForgotPasswordButton: _onTapForgotPasswordButton,
                      onTapSingUpButton: _onTapSingUpButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (_formKey.currentState!.validate()) {
      final SignInController signInController = Get.find<SignInController>();
      final bool result = await signInController.signIn(
        _emailTEController.text.trim(),
        _passwordTEController.text,
      );
      if (result) {
        Get.offAll(
          () => const BottomNavMainScreen(),
        );
      } else {
        if (mounted) {
          snackBarMessage(
            context,
            signInController.errorMessage,
          );
        }
      }
    }
  }

  void _onTapSingUpButton() {
    Get.to(() => const SignUpScreen());
  }

  void _onTapForgotPasswordButton() {
    Get.to(() => const EmailVerificationScreen());
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
