import 'package:byte_logik_task/app/data/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  var authService = Get.find<AuthService>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signUp(String email, String password, String name) {
    authService.signUpWithEmail(email, password,name);
  }

  void signIn(String email, String password) {
    authService.loginWithEmail(email, password);
  }
}
