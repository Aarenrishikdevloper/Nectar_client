import 'dart:async';
import 'dart:convert';


import 'package:get/get.dart';
import 'package:nectar/models/OrderDeletemodel.dart';


import '../commons/constants.dart';
import '../commons/utils.dart';
import '../models/order.dart';
import "package:http/http.dart" as http;
class OrderController extends GetxController{
  RxList<Orders>orders = <Orders>[].obs;
  final Orderdetails = Rxn<OrderDetailModel>();
  final isloading = false.obs;
  final baseurl = constants.baseurl;

  Timer? _pollingTimer;
  @override
 void onInit() {
    _startpolling();
    super.onInit();
  }
  void _startpolling(){
    _pollingTimer = Timer.periodic((Duration(seconds:5)), (timer){
      fetchorder();
    });
  }
 @override
 void onClose(){
    _pollingTimer?.cancel();
    super.onClose();
 }
  Future<void>getorder()async{
    try{
      utils.showHUD();
      isloading.value = true;
      final token =  await utils.getToken() as String;
      print(token);
      final userId =  utils.verifyJwt(token);
      final uri = '${baseurl}/user/order?userId=${userId}';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data =json.decode(res.body);
        print(data);
        orders.value =(data['order'] as List)
            .map((model)=>Orders.fromJson(model)).toList();
        print(orders.value);
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
  Future<void>fetchorder()async{
    try{

      final token =  await utils.getToken() as String;
      print(token);
      final userId =  utils.verifyJwt(token);
      final uri = '${baseurl}/user/order?userId=${userId}';
      final res = await http.get(Uri.parse(uri));
      if(res.statusCode == 200){
        var data =json.decode(res.body);
        print(data);
        orders.value =(data['order'] as List)
            .map((model)=>Orders.fromJson(model)).toList();
        print(orders.value);
      }else{

        Get.snackbar("Error", "Something Went Wrong");
      }
    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }

  }
  void updateOrder(String orderId, String status){
    final orderIndex = orders.indexWhere((order)=>order.id == orderId);
    if(orderIndex != -1){
      orders[orderIndex].orderStatus = status;
      orders.refresh();
    }
  }

}