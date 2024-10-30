import 'dart:convert';

import 'package:get/get.dart';
import "package:http/http.dart" as http;
import '../commons/constants.dart';
import '../commons/utils.dart';

class ForgotpasswordService extends GetxController{
  final baseurl = constants.baseurl;
  final isloading = false.obs;

  Future<bool>getverificationCode(String email)async {
    try {
      isloading.value = true;

      String uri = "${baseurl}/user/verify";
      var body = jsonEncode({
        'email': email
      });
      final res = await http.post(
        Uri.parse(uri), headers: {"Content-Type": "application/json"},
        body: body,);
      if (res.statusCode == 200) {
        Get.snackbar(
            "code Verification Sucessfully", "Code Verification Sucessfully");
        return true;
      } else {
        Get.snackbar("Error", "something went Wrong");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "something went Wrong");
      print(e);
      return false;
    } finally {
      isloading.value = false;
    }
  }
  Future<bool>verificationCode(String email, String Code)async {
    try {
      isloading.value = true;

      String uri = "${baseurl}/user/verify-code";
      var body = jsonEncode({
        'email':email ,
         "code":Code
      });
      final res = await http.post(
        Uri.parse(uri), headers: {"Content-Type": "application/json"},
        body: body,);
      if (res.statusCode == 200) {
        Get.snackbar(
            "code Verification Sucessfully", "Code Verification Sucessfully");
        return true;
      } else {
        Get.snackbar("Error", "something went Wrong");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "something went Wrong");
      print(e);
      return false;
    } finally {
      isloading.value = false;
    }
  }
  Future<bool>changepassword(String password, String email)async{

    try{
      isloading.value = true;

      String uri =  "${baseurl}/user/Forgotpassword";
      var body = jsonEncode({
        'email':email,
        'password':password
      });
      final res = await http.patch(
        Uri.parse(uri), headers: {"Content-Type": "application/json"},
        body: body,);
      if(res.statusCode == 200){
        Get.snackbar("Password Change Sucessfully", "Password Change Sucessfull");
        return true;
      }else{
        Get.snackbar("Error", "something went Wrong");
        return false;
      }

    }catch(e){
      Get.snackbar("Error", "something went Wrong");
      print(e);
      return false;

    }finally{
      isloading.value = false;
    }
  }
}


