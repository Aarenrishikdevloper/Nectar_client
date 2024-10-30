

import 'dart:convert';



import 'package:get/get.dart';
import 'package:nectar/Comom_widget/CartItems.dart';

import 'package:nectar/commons/utils.dart';
import 'package:http/http.dart' as http;
import 'package:nectar/models/Adressmodel.dart';
import 'package:nectar/models/Promomodel.dart';
import 'package:nectar/models/cartmodel.dart';
import 'package:nectar/models/paymentmodel.dart';
import 'package:nectar/view/Cart/Error.dart';
import 'package:nectar/view/Cart/Sucess.dart';
import '../commons/constants.dart';

class CartService extends GetxController {
  final qty = 1.obs;

  final isloading = false.obs;
  final baseurl = constants.baseurl;
  RxList<CartModel>Cartlist = <CartModel>[].obs;
  final promobj = Promo().obs;
  void addsubqty({isAdd = true}) {
    if (isAdd) {
      qty.value = qty.value + 1;
      if (qty.value > 99) {
        qty.value = 99;
      }
    } else {
      qty.value = qty.value - 1;
      if (qty.value < 1) {
        qty.value = 1;
      }
    }
  }

  final deliverytype = "Delivery".obs;
  final paymenttype = "1".obs;
  final deliveryobj = AddressModel().obs;
  final paymentobj = Payment().obs;
  var deliveryprices;
  var discountprice;



  String pricevalue(deliveryprice, discountprice) {
    var cost = totalPrice + deliveryprice.toInt() - discountprice.toInt() ;

    return cost.toString();
  }

  double get totalPrice =>
      Cartlist.value.fold(0.0, (sum, item) => sum + item.price);

  static void serviceCallAddtocart(String prodId, int qty, double price) async {
    print(qty);
    try {



      final token = await utils.getToken() as String;
      final userId = await utils.verifyJwt(token);
      var body = json.encode({
        'productId': prodId,
        'qty': qty,
        "price": price,
        "userId": userId
      });


      String url = "https://nectar-backend.onrender.com/api/user/addtocart";
      final res = await http.post(
          Uri.parse(url), headers: {"Content-Type": "application/json"},
          body: body);
      if (res.statusCode == 200) {
        Get.snackbar("Added To Cart Sucessfully", "Sucessfully Added to Cart");
      } else {
        Get.snackbar("Error", "something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "something went wrong");
      print(e);
    }
  }

  static void serviceCallEditCart(String prodId, int qty, double price) async {
    try {


      final token = await utils.getToken() as String;
      final userId = await utils.verifyJwt(token);
      var body = json.encode({
        'productId': prodId,
        "qty": qty,
        "price": price,
        "userId": userId
      });
      String url = "https://nectar-backend.onrender.com/api/user/cartItems";
      final res = await http.patch(
          Uri.parse(url), headers: {"Content-Type": "application/json"},
          body: body);
      if (res.statusCode == 200) {
        Get.snackbar("Sucess", "sucessfully");
      }
    } catch (e) {
      Get.snackbar("Error", "something went wrong");
      print(e);
    }
  }

  Future<void> fetchdata() async {
    try {
      utils.showHUD();
      isloading.value = true;
      var token = await utils.getToken();
      final userId = utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/cartItems?userId=$userId";
      final res = await http.get(
          Uri.parse(uri), headers: {"Content-Type": "application/json"});
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        Cartlist.value = (data['cart'] as List)
            .map((model) => CartModel.fromJson(model)).toList();
      }
      print(Cartlist);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    } finally {
      utils.hideHud();
      isloading.value = false;
    }
  }

  Future<void> deleteitem(String productid) async {
    try {
      Cartlist.value.removeWhere((item) => item.productid == productid);
      //refressing the ui
      Cartlist.refresh();
      final token = await utils.getToken();
      final userId = utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/cartitem?productid=$productid&userId=$userId";
      final res = await http.delete(
          Uri.parse(uri), headers: {"Content-Type": "application/json"});
      if (res.statusCode == 200) {
        Get.snackbar("remove Sucessfully", "remove Sucessfully");
      } else {
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    }
  }

  Future<void> serviceCallEditqtyCart(String prodId, int qty,
      double price) async {
    try {
      final token = await utils.getToken() as String;
      final userId = await utils.verifyJwt(token);
      var body = json.encode({
        'productId': prodId,
        "qty": qty,
        "price": price,
        "userId": userId
      });
      String url = "https://dear-civet-subtly.ngrok-free.app/api/user/cartItems";
      final res = await http.patch(
          Uri.parse(url), headers: {"Content-Type": "application/json"},
          body: body);
      if (res.statusCode == 200) {
        Cartlist.refresh();
        Get.snackbar("Sucess", "sucessfully");
      }
    } catch (e) {
      Get.snackbar("Error", "something went wrong");
      print(e);
    }
  }

  Future<void> createorder(List<Map<String, dynamic>>products,
      double userpayprice, double deliveryprice, String?addressid) async {
    try {
      isloading.value = true;
      final token = await utils.getToken() as String;
      final userId = await utils.verifyJwt(token);
      if (addressid!.isEmpty && deliverytype.value == "Delivery") {
        Get.snackbar("Error", "Address is required in delivery mode");
        return;
      }
    var body = jsonEncode({
    "userId": userId,
    'products': products,
    'delivery_type': deliverytype.value.toString(),
    'total_price': totalPrice,
    'user_pay_price': userpayprice,
    'delivery_price': 20,
    'payment_type': "Cash",
    'address_id': addressid});

      String uri = "${baseurl}/user/createorder";
      final res = await http.post(Uri.parse(uri), body: body,
        headers: {'Content-Type': 'application/json'},);
      if (res.statusCode == 200) {
        Cartlist.clear();
        Cartlist.refresh();
        Get.snackbar("Sucessfull Order creation", "Order createsd Sucessfully");

        Get.off(() => Sucess());
      } else {
        Get.snackbar("Error", "Something went wrong");
        Get.to(() => ErrorPage());
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
      Get.to(() => ErrorPage());
    } finally {
      isloading.value = false;
    }
  }


Future<void> createorderOnline(List<Map<String, dynamic>>products,double userpayprice, double deliveryprice, String?addressid,double delivery_price, double discountprice) async{
     try{
       isloading.value = true;
       final token = await utils.getToken() as String;
       final userId  = await utils.verifyJwt(token);
       if(addressid!.isEmpty && deliverytype.value == "Delivery"){
         Get.snackbar("Error", "Address is required in delivery mode");
         return;
       }



       var body = jsonEncode({
         "userId":userId,
         'products':products,
         'delivery_type':deliverytype.value.toString(),
         'total_price':totalPrice,
         'user_pay_price':userpayprice,
         "delivery_price":deliveryprice,
         "discountprice":discountprice,


         'payment_type':"Online",
         'address_id':addressid,


       });

         String uri =  "${baseurl}/user/online";
         final res= await http.post(Uri.parse(uri), body:body,  headers: {'Content-Type': 'application/json'},);
         if(res.statusCode == 200){
           Cartlist.clear();
           Cartlist.refresh();
           Get.off(()=>Sucess());
         }else{
           Get.snackbar("Error", "Something went wrong");
           Get.to(()=>ErrorPage());
         }



     }catch(e){
       Get.snackbar("Error", "Something went wrong");
       print(e);
       Get.to(()=>ErrorPage());
     }finally{
       isloading.value = false;
     }

 }


}
