import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../commons/constants.dart';
import '../commons/utils.dart';
class Reviewservice extends GetxController {
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  final rating = 0.0.obs;
  Future<bool> review(String productId, String comment) async {

    try {
      isloading.value = true;
      final token = await utils.getToken();
      final userId = utils.verifyJwt(token as String);
      var body = json.encode({
        "userId": userId,
        "rating": rating.toDouble(),
        "comment": comment,
        "productId": productId
      });
      String uri = '${baseurl}/user/review';
      final res = await http.post(Uri.parse(uri), body: body,
          headers: {"Content-Type": "application/json"});
      if (res.statusCode == 200) {

        rating.value = 0.0;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);

      return false;
    }finally{
      isloading.value = false;
    }
  }
}