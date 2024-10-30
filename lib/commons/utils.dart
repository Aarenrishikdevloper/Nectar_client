import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:nectar/commons/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class utils {
  static const String tokenkey = 'jwttoken';

  static Future<void> storetoken(String token) async {
    final preps = await SharedPreferences.getInstance();
    await preps.setString(tokenkey, token);
  }

  static Future<String?> getToken() async {
    final preps = await SharedPreferences.getInstance();
    return preps.getString(tokenkey);
  }

  static String verifyJwt(String token) {
    String trimmedToken = token.substring(1, token.length - 1);
    print(trimmedToken);
    final jwt = JWT.verify(trimmedToken, SecretKey(constants.jwttoken));
    final userId = jwt.payload['userid'];
    return userId as String;
  }

  static void showHUD({String status = "loading....."}) async {
    await Future.delayed(const Duration(microseconds: 1));
    EasyLoading.show(status: status);
  }

  static void hideHud() {
    EasyLoading.dismiss();
  }

  static String formatPrice(double Price) {
  final formatter = NumberFormat.currency(
    locale: 'hi_IN',
    symbol: '₹',
  );
  var format = formatter.format(Price);
  //final decimalIndex = format.indexOf('.');
  //if(decimalIndex != -1){
    //format = format.substring(0, decimalIndex);
  //}

  return format as String;

}
  static List<Color> usedColors = [];
static getRandomColor(){
  if (constants.colors.isEmpty) {
    throw Exception("No colors available");
  }

  if (usedColors.length == constants.colors.length) {
    // All colors have been used; reset the used colors list
    usedColors.clear();
  }
    Random random = Random();
   List<Color> avalaiblecolor = constants.colors.where((color)=>!usedColors.contains(color)).toList();
   Color randomcolor =avalaiblecolor[random.nextInt(avalaiblecolor.length)];
   usedColors.add(randomcolor);
   return randomcolor;
}
  static String getorderstatus(String status) {
    switch (status) {
      case "pending":
        return "Pending";
      case "delivered":
        return "Delivered";
      case "Accepted":
        return "Accepted";
      case "cancelled":
        return "Cancelled";
      case 'return':
        return "Return";
      case 'refund':
        return "Refund";
      default:
        return '';
    }
  }

 static Color getorderColor(String status) {
    switch (status) {
      case "pending":
        return Colors.blue;
      case "delivered":
        return Colors.green;
      case "Accepted":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      case 'return':
        return Colors.red;
      case 'refund':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

 static Color getorderColorPayment(String status) {
    switch (status) {
      case "waiting":
        return Colors.yellow;
      case "done":
        return Colors.green;
      case "fail":
        return Colors.red;

      case 'refund':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  static String getorderPayment(String status) {
    switch (status) {
      case "waiting":
        return "Waiting";
      case "done":
        return "Done";
      case "fail":
        return "Fail";

      case 'refund':
        return "Refund";
      default:
        return "";
    }
  }
  static String formatDate(DateTime date){
    DateFormat formatter = DateFormat('dd-MM-yyy');
    return formatter.format(date);
  }
}