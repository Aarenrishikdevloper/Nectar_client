import 'package:get/get.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/view/Maintabview/maintabview.dart';
import 'package:nectar/view/login/Welcome.dart';

class SplashService extends GetxController {
  void navigatewelcomescreen() async {
    await Future.delayed(Duration(seconds: 3));
    final token = await utils.getToken();

    if (token != null) {
      Get.offAll(() => const maintabview());
    } else {
      Get.offAll(() => const Welcome());
    }
  }
}
