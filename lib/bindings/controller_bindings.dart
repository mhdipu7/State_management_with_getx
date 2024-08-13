import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/add_new_task_controller.dart';
import 'package:task_manager_app/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager_app/ui/controller/completed_task_controller.dart';
import 'package:task_manager_app/ui/controller/email_verification_controller.dart';
import 'package:task_manager_app/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager_app/ui/controller/new_task_controller.dart';
import 'package:task_manager_app/ui/controller/pin_verification_controller.dart';
import 'package:task_manager_app/ui/controller/reset_password_controller.dart';
import 'package:task_manager_app/ui/controller/sign_in_controller.dart';
import 'package:task_manager_app/ui/controller/sign_up_controller.dart';
import 'package:task_manager_app/ui/controller/update_profile_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => EmailVerificationController());
    Get.lazyPut(() => PinVerificationController());
    Get.lazyPut(() => ResetPasswordController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => InProgressTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => CancelledTaskController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => UpdateProfileController());
  }
}
