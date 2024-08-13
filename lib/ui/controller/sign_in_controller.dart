import 'package:get/get.dart';
import 'package:task_manager_app/data/model/login_model.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class SignInController extends GetxController {
  bool _signInAPIInProgress = false;
  String _errorMessage = '';

  bool get signInAPIInProgress => _signInAPIInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _signInAPIInProgress = true;
    update();

    Map<String, dynamic> requestData = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.logIn, body: requestData);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.reponseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Login failed! Try again.';
    }
    _signInAPIInProgress = false;
    update();
    return isSuccess;
  }
}
