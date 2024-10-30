

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nectar/models/Adressmodel.dart';
import 'package:nectar/models/usermodel.dart';
import 'package:nectar/view/Maintabview/maintabview.dart';

import '../commons/constants.dart';
import '../commons/utils.dart';
import "package:http/http.dart" as http;

import '../view/account/adress_screen.dart';
class AdressCreateService extends GetxController{
  final isloading = false.obs;
  final baseurl = constants.baseurl;
  final txtType = "Home".obs;

  void serviceCreateAdress(String name, String mobileno, String adressLine, String City, String State, String PostalCode, String type)async{
    try{
      isloading.value = true;
      final uri = '${baseurl}/user/address';
      final token =  await utils.getToken() as String;
      print(token);
     final userId =  utils.verifyJwt(token);
      final body =jsonEncode(
        {
           "name":name,
           "mobile":mobileno,

            "adressline":adressLine,
            "city":City,
             "state":State,
            "userId":userId,
            "postalcode":PostalCode ,
            "type":type



        }
      );
      final res = await http.post(Uri.parse(uri),body:body, headers:{"Content-Type":"application/json"} );
      if(res.statusCode == 201){




        Get.off(()=>AdressScreen());

      }else{
        Get.snackbar("Error", "Something Went Wrong");

      }

    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      isloading.value = false;
    }
  }
  void servicelocation( String City, String State)async{
    try{
      isloading.value = true;
      final uri = '${baseurl}/user/location';
      final token =  await utils.getToken() as String;
      print(token);
      final userId =  utils.verifyJwt(token);
      final body =jsonEncode(
          {

            "city":City,
            "state":State,
            "userid":userId,




          }
      );
      final res = await http.post(Uri.parse(uri),body:body, headers:{"Content-Type":"application/json"} );
      if(res.statusCode == 200){



        Get.to(()=> const maintabview());

      }else{
        Get.snackbar("Error", "Something Went Wrong");

      }

    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      isloading.value = false;
    }
  }
  void serviceUpdateAdress(String id,String name, String mobileno, String adressLine, String City, String State, String PostalCode, String type)async{
    try{
      isloading.value = true;
      final uri = '${baseurl}/user/address?id=${id}';
      final body =jsonEncode(
          {
            "name":name,
            "mobile":mobileno,

            "adressline":adressLine,
            "city":City,
            "state":State,

            "postalcode":PostalCode ,
            "type":type



          }
      );
      final res = await http.patch(Uri.parse(uri),body:body, headers:{"Content-Type":"application/json"} );
      if(res.statusCode == 200){




        Get.off(()=>AdressScreen());

      }else{
        Get.snackbar("Error", "Something Went Wrong");

      }

    }catch(e){
      print(e);
      Get.snackbar("Error", "Something Went Wrong");
    }finally{
      isloading.value = false;
    }
  }
}


