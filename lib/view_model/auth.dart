import "dart:convert";

import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:nectar/commons/constants.dart";
import "package:nectar/commons/utils.dart";
import "package:nectar/models/usermodel.dart";
import "package:nectar/view/Maintabview/maintabview.dart";
import "package:nectar/view/login/Login.dart";
import "package:nectar/view/login/adress_screen.dart";
import "package:shared_preferences/shared_preferences.dart";


class AuthViewModel extends GetxController {
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  final isShowpassword = false.obs;


  void serviceCallSignUp(String email, String username, String password) async {
    try {
      isloading.value = true;
      String uri = "${baseurl}/user/sign_up";

      String body = jsonEncode(
          {"email": email, "password": password, "username": username});
      var res = await http.post(Uri.parse(uri),
          body: body, headers: {"Content-Type": "application/json"});
      if (res.statusCode == 201) {
        Get.snackbar("Registration Sucessfull", " Account Created Sucessfully");
        String token = res.body;
        await utils.storetoken(token);
        Get.offAll(() => const adressCreation());
      } else {
        Get.snackbar("Error", "Something Went Wrong");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    } finally {
      isloading.value = false;
    }
  }

  void serviceCallSignIn(String email, String password) async {
    try {
      isloading.value = true;
      String uri = "${baseurl}/user/login";

      String body = jsonEncode({
        "email": email,
        "password": password,
      });
      var res = await http.post(Uri.parse(uri),
          body: body, headers: {"Content-Type": "application/json"});
      if (res.statusCode == 200) {
        Get.snackbar("Login Sucessfull", "login Sucessfully");
        String token = res.body;
        await utils.storetoken(token);
        Get.offAll(() => const maintabview());
      } else {
        Get.snackbar("Error", "Something Went Wrong");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    } finally {
      isloading.value = false;
    }
  }
  void showPassword(){
    isShowpassword.value = !isShowpassword.value;
}
void logout()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.off(()=>Login());

}


}
