import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/Promomodel.dart';

import '../commons/constants.dart';
import "package:http/http.dart" as http;
class fetchpromo extends GetxController{
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  Rx<List<Promo>> promo = Rx([]);
  Timer? _pollingTimer;
  @override
  void onInit() {
    _startpolling();
    super.onInit();
  }
  void _startpolling(){
    _pollingTimer = Timer.periodic((Duration(seconds:5)), (timer){
      getpromocode();
    });
  }
  @override
  void onClose(){
    _pollingTimer?.cancel();
    super.onClose();
  }
  Future<void>fetchpromocode()async{
    try{
      utils.showHUD();
      final uri = '${baseurl}/user/promo';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data =json.decode(res.body);
        promo.value =(data['promo'] as List)
            .map((model)=>Promo.fromJson(model)).toList();
        print(promo.value);
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "something Went Wrong");
    }finally{
      utils.hideHud();
    }
  }
  Future<void>getpromocode()async{
    try{

      final uri = '${baseurl}/user/promo';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data =json.decode(res.body);
        promo.value =(data['promo'] as List)
            .map((model)=>Promo.fromJson(model)).toList();
        print(promo.value);
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "something Went Wrong");
    }
  }


}