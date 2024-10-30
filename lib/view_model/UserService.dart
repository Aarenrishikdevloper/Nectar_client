

import 'dart:convert';

import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:nectar/models/usermodel.dart';
import '../commons/constants.dart';
import '../commons/utils.dart';

class Userservice extends GetxController {
  final baseurl = constants.baseurl;
  final isloading = false.obs;
  final userdetails = Rxn<UserModel>();

  Future<void> Userdetails() async {
    try {
      utils.showHUD();
      isloading.value = true;
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/user?userId=${userId}";
      var res = await http.get(Uri.parse(uri));
      if (res.statusCode == 200) {
        final data = json.decode(res.body)['userdata'];
        print(data);
        userdetails.value = UserModel.fromJson(data);
      } else {
        Get.snackbar("Error", "Something Went Wrong");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    } finally {
      utils.hideHud();
      isloading.value = false;
    }
  }


  Future<void> UserUpdate(String username, String email, String CountryCode,
      String mobileno) async {
    try {
      isloading.value = true;
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/users";
      var body = jsonEncode({
        "name": username,
        "email": email,
        "countrycode": CountryCode,
        "mobileno": mobileno,
        "userId": userId
      });
      final res = await http.patch(
        Uri.parse(uri), headers: {"Content-Type": "application/json"},
        body: body,);
      if (res.statusCode == 200) {
       print(res.body);
        var userdata = jsonDecode(res.body);
        userdetails.value = UserModel(
            name:userdata['username'],
            email:userdata['email']
        );
        Get.snackbar("Updated Sucessfully", "Updated the details Sucessfully");
      }
    } catch (e) {
      Get.snackbar("Error", "something went Wrong");
      print(e);
    } finally {
      isloading.value = false;
    }
  }
  Future<bool>changepassword(String password)async{

    try{
      isloading.value = true;
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri =  "${baseurl}/user/changepassword";
      var body = jsonEncode({
         'userId':userId,
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