import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/Adressmodel.dart';

class fetchAdress extends GetxController{
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  Rx<List<AddressModel>> adddress = Rx([]);
  Future<void>fetchadress()async{
    try{
      utils.showHUD();
      isloading.value = true;
      final token =  await utils.getToken() as String;
      print(token);
      final userId =  utils.verifyJwt(token);
      final uri = '${baseurl}/user/address?userId=${userId}';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data =json.decode(res.body);
        adddress.value =(data['address'] as List)
            .map((model)=>AddressModel.fromJson(model)).toList();
        print(adddress.value);
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
    adddress.value.clear();
  }
  Future<void> deleteasress(String id)async{
    try{

      adddress.value.removeWhere((item)=>item.id == id);
      //refressing the ui
      adddress.refresh();

      String uri = "${baseurl}/user/address?id=${id}";

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