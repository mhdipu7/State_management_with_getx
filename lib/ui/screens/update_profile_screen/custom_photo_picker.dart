import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/update_profile_controller.dart';
import 'package:task_manager_app/ui/utility/app_colors.dart';

Widget customPhotoPicker() {
  return GetBuilder<UpdateProfileController>(
    builder: (updateProfileController) {
      return GestureDetector(
        onTap: updateProfileController.pickedProfileImage,
        child: Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Photo",
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  updateProfileController.selectedImage?.name ??
                      "No image selected",
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
