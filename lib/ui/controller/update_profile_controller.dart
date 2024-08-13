import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/model/network_response.dart';
import 'package:task_manager_app/data/model/user_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utilities/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  String _errorMessage = '';
  XFile? _selectedImage;


  bool get updateProfileInProgress => _updateProfileInProgress;
  String get errorMessage => _errorMessage;
  XFile? get selectedImage => _selectedImage;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password, VoidCallback profileUpdateSuccess) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    String encodePhoto = AuthController.userData?.photo ?? '';
    update();

    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      requestInput['password'] = password;
    }

    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestInput['photo'] = encodePhoto;
    }

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: requestInput);

    if (response.isSuccess && response.reponseData['status'] == 'success') {
      UserModel userModel = UserModel(
        photo: encodePhoto,
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
      );
      await AuthController.saveUserData(userModel);
      profileUpdateSuccess();
    } else {
      _errorMessage =
          response.errorMessage ?? 'Profile update failed! Try again.';
    }

    _updateProfileInProgress = false;
    update();

    return isSuccess;
  }





  Future<void> pickedProfileImage() async {
    final imagePicker = ImagePicker();
    final XFile? result = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (result != null) {
      _selectedImage = result;
      update();
    }
  }



}
