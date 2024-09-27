
import 'package:byte_logik_task/app/data/model/user_model.dart';
import 'package:byte_logik_task/app/data/service/auth_service.dart';
import 'package:byte_logik_task/app/data/service/user_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var  userService =Get.find<UserService>();
  final count = 0.obs;
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getData() async {
    userModel.value = (await userService.getUser())!;
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> increment() async {
     var userModel = await userService.getUser();
     userModel!.counterValue++;
     userModel.lastCounterUpdate=DateTime.now();
     userService.updateUser(userModel);
     count.value=userModel.counterValue;
  }
  void logout() => Get.find<AuthService>().logout();
}
