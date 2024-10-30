import 'dart:convert';

import 'package:get/get.dart';

import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/paymentmodel.dart';
import 'package:http/http.dart' as http;
class fetchpayment extends GetxController{
  Rx<List<Payment>> PaymentList = Rx([]);
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  Future<void>fetchmethods()async{
    try{
      utils.showHUD();
      isloading.value = true;
      final token =  await utils.getToken() as String;
      print(token);
      final userId =  utils.verifyJwt(token);
      final uri = '${baseurl}/user/payment?userId=${userId}';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data =json.decode(res.body);
        PaymentList.value =(data['payment'] as List)
            .map((model)=>Payment.fromJson(model)).toList();
        print(PaymentList.value);
      }
    }catch(e) {
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      utils.hideHud();
      isloading.value = false;
    }
  }
  void clearAll(){
    PaymentList.value.clear();
  }
  Future<void> deletemethod(String id)async{
    try{

      PaymentList.value.removeWhere((item)=>item.id == id);
      //refressing the ui
      PaymentList.refresh();

      String uri = "${baseurl}/user/payment?id=${id}";


      final res = await http.delete(Uri.parse(uri),headers:{"Content-Type":"application/json"});
      if(res.statusCode == 200){
        Get.snackbar("remove Sucessfully", "remove Sucessfully");
      }else{
        Get.snackbar("Error", "Something went wrong");
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }
  }
}