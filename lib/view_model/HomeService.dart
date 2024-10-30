
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/Adress.dart';
import 'package:nectar/models/Product.dart';
import "package:http/http.dart" as http;
import 'package:nectar/view/Cart/Sucess.dart';
import 'package:nectar/view/global_view/Error.dart';

import '../commons/constants.dart';
import '../models/Offer.dart';

class Homeservice extends GetxController {
  Rx<Address> address = Address(state: "", city: "").obs;
  RxList<Product> latestProduct = <Product>[].obs;
  RxList<Product> otherproducts = <Product>[].obs;
  RxList<Offer> offers = <Offer>[].obs;
  final baseurl = constants.baseurl;
  final isloading = false.obs;
  Timer? _pollingTimer;

  void _startpolling(){
    _pollingTimer = Timer.periodic((Duration(seconds:5)), (timer){
     polldata();
    });
  }
  @override
  void onInit() {
    fetchdata();
    _startpolling();

    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose(){
    _pollingTimer?.cancel();
    super.onClose();
  }


  void fetchdata() async {
    try {
      isloading.value = true;
      utils.showHUD();
      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/home?userId=${userId}";
      final res = await http
          .get(Uri.parse(uri), headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        address.value = Address.fromJson(data["location"]);
        print(address.value);
        Iterable latest = data['latestProduct'];
        print(latest);
        latestProduct.assignAll(latest.map((model) => Product.fromJson(model)));
        Iterable offer = data['offer'];
        offers.assignAll(offer.map((model) => Offer.fromJson(model)));
        print(offer);
        Iterable other = data['otherporucts'];
        otherproducts.assignAll(other.map((model) => Product.fromJson(model)));
        print(other);
      } else {
        Get.off(() => ErrorPage());
      }
    } catch (e) {
      print(e);
      Get.off(() => ErrorPage());
      Get.snackbar(
        "Error",
        "data detching failed",
      );
    } finally {
      isloading.value = false;
      utils.hideHud();
    }
  }
  void polldata() async {
    try {

      final token = await utils.getToken();
      final userId = await utils.verifyJwt(token as String);
      String uri = "${baseurl}/user/home?userId=${userId}";
      final res = await http
          .get(Uri.parse(uri), headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        address.value = Address.fromJson(data["location"]);
        print(address.value);
        Iterable latest = data['latestProduct'];
        print(latest);
        latestProduct.assignAll(latest.map((model) => Product.fromJson(model)));
        Iterable offer = data['offer'];
        offers.assignAll(offer.map((model) => Offer.fromJson(model)));
        print(offer);
        Iterable other = data['otherporucts'];
        otherproducts.assignAll(other.map((model) => Product.fromJson(model)));
        print(other);
      }
    } catch (e) {
      print(e);

    }
  }
}
