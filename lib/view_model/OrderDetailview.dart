import 'dart:convert';

import 'package:get/get.dart';

import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/OrderDeletemodel.dart';
import 'package:http/http.dart' as http;
class Orderdetailview extends GetxController{
  final Orderdetails = Rxn<OrderDetailModel>();
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  final  rating = 0.0.obs;
  Future<void> getorderDetails(String id)async{
    try{
      utils.showHUD();
      isloading.value = true;
      final uri = '${baseurl}/user/orderdetails?orderId=${id}';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        final data = json.decode(res.body)['order'];
        print(data);
        Orderdetails.value = OrderDetailModel.fromJson(data);



      }else{

        Get.snackbar("Error", "Something Went Wrong");
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      utils.hideHud();
      isloading.value = false;
    }
  }

}