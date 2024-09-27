import 'package:byte_logik_task/app/data/service/user_service.dart';
import 'package:get/get.dart';

import '../../../data/service/auth_service.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
