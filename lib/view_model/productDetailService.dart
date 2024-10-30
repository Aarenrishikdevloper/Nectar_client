import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:nectar/commons/utils.dart';
import 'package:http/http.dart' as http;

import '../commons/constants.dart';
import '../models/productModel.dart';

class Productdetailservice extends GetxController{


  final baseurl = constants.baseurl;
  final isloading = false.obs;
  final showdescription = false.obs;
  final Productdetails = Rxn<ProductDetails>();
  final status = false.obs;
  final qty = 1.obs;
  void addsubqty({isAdd = true}){
     if(isAdd){
       qty.value = qty.value + 1;
       if(qty.value > 99){
         qty.value = 99;
       }
     } else{
       qty.value = qty.value - 1;
       if(qty.value < 1){
         qty.value = 1;
       }
     }

  }

  Future<void> fetchdetails(String id)async{
    try{
      utils.showHUD();
      isloading.value = true;
      final token = await utils.getToken();
      final userId =await utils.verifyJwt(token as String);
      String url= "${baseurl}/user/details?id=$id&userId=$userId";
      final res = await http.get(Uri.parse(url), headers:{"Content-Type":"application/json"});
      if(res.statusCode == 200){
        final data = json.decode(res.body)['details'];
        print(data);
        Productdetails.value = ProductDetails.fromJson(data);
        status.value = Productdetails.value?.status as bool;
        print(res.body);

      }else{
        Get.snackbar("Error", "Something went wrong");
      }

    }catch(e){
      print(e);
      Get.snackbar("Error", "Something went wrong");
    }finally{
      utils.hideHud();
      isloading.value = false;

  }
  }
  Future<void>getdetails(String id)async{
    try{
      utils.showHUD();
      isloading.value = true;
      final token = await utils.getToken();
      final userId =await utils.verifyJwt(token as String);
      String url= "${baseurl}/user/details?id=$id&userId=$userId";
      final res = await http.get(Uri.parse(url), headers:{"Content-Type":"application/json"});
      if(res.statusCode == 200){
        final data = json.decode(res.body)['details'];
        print(data);
        Productdetails.value = ProductDetails.fromJson(data);
        status.value = Productdetails.value?.status as bool;
        print(res.body);

      }else{
        Get.snackbar("Error", "Something went wrong");
      }

    }catch(e){
      print(e);
      Get.snackbar("Error", "Something went wrong");
    }
  }
  Future<void> toggleFav( String productId)async{
    try{

       final token  = await utils.getToken();
       final userId = await  utils.verifyJwt(token as String);
       String url= "${baseurl}/user/fav";
       var body= json.encode({
         "productId":productId,
         "userId":userId
       });
       final res  = await http.post(Uri.parse(url),headers:{"Content-Type":"application/json"}, body:body );
       if(res.statusCode == 200){
         final data = jsonDecode(res.body);
         status.value = data['status'];
       }
    }catch(e){
      Get.snackbar("Error", "Something Went Wrong");
      print(e);

    }finally{

    }


  }



}