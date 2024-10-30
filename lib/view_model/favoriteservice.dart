import 'dart:convert';

import 'package:get/get.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/Favorite.dart';
import 'package:http/http.dart' as http;
import '../commons/constants.dart';


class FavService extends GetxController {
  Rx<List<Favorite>> favProduct = Rx([]);
  final baseurl = constants.baseurl;
  final isloading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    fetchdata();
    super.onInit();

  }
  void fetchdata()async{
    try{
      utils.showHUD();
      isloading.value = true;
      final token = await utils.getToken();
      final userId = utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/favorites?userId=${userId}";
      final res = await http.get(Uri.parse(uri),headers:{"Content-Type":"application/json"} );
      if(res.statusCode == 200){
        final data = json.decode(res.body);
        favProduct.value =(data['favproducts'] as List) 
            .map((model)=>Favorite.fromJson(model)).toList();

       print(res.body);
      }else{
        Get.snackbar("Error", "Some went wrong");
      }

    }catch(e){
      print(e);
      Get.snackbar("Error", "Some went wrong");

    }finally{
      isloading.value = false;
      utils.hideHud();
    }

  }
  Future<void>AddAlltocart(List<Map<String, dynamic>>products)async{
    try{
      isloading.value = true;
      final token = await utils.getToken();
      final userId = utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/cart_fav";
      var body = jsonEncode({
        "userId":userId,
        "products":products
      });
      final res = await http.post(Uri.parse(uri),body:body,  headers: {'Content-Type': 'application/json'},);
      if(res.statusCode == 200){
        favProduct.value.clear();
        favProduct.refresh();
        Get.snackbar("Added To cart", "Added to cart Sucessfully");

      }

    }catch(e){
      print(e);
      Get.snackbar("Error", "Some went wrong");
    }
  }
}