import 'dart:convert';

import 'package:get/get.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/Product.dart';
import 'package:http/http.dart' as http;

import '../commons/constants.dart';
class Searchcontroller extends GetxController{

  final baseurl = constants.baseurl;
  final isloading = false.obs;
  Rx<List<Product>> searchresult = Rx([]);
  Rx<List<Product>> catproduct = Rx([]);
  Future<void> searchquery(String query)async{


    try{
      if(query.isEmpty){

        searchresult.value.clear();
        return;

      }
      utils.showHUD();
      isloading.value = true;

      String uri = "${baseurl}/user/search?searchterm=${query}";
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data = json.decode(res.body);


        searchresult.value =(data['search'] as List)
            .map((model)=>Product.fromJson(model)).toList();

        print(searchresult);
      }else{
        Get.snackbar("Error", "something went Wrong");
      }

    }catch(e){
      Get.snackbar("Error", "something went Wrong");
      print(e);
    }finally{
      utils.hideHud();
      isloading.value = false;
    }
  }
  Future<void>getcat(String cat)async{
    try{
       utils.showHUD();
       isloading.value = true;
       final uri ="${baseurl}/user/category?category=${cat}";
       final res = await http.get(Uri.parse(uri));
       if(res.statusCode == 200){
         var data = json.decode(res.body);
         print(data);
         catproduct.value =(data['catproduct'] as List)
             .map((model)=>Product.fromJson(model)).toList();
       }
       else{
         Get.snackbar("Error", "Something went wrong");
       }

    }catch(e){
      Get.snackbar("Error", "something went Wrong");
      print(e);
    }finally{
      utils.hideHud();
      isloading.value = false;
    }
  }
}
