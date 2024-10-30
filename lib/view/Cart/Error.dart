import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view_model/addcartservice.dart';

import '../Maintabview/maintabview.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: Container(
          width: media.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
      
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/img/order_fail.png",
                width: media.width * 0.5,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Oops! Order Failed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Tcolor.primarytext,
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
             SizedBox(height:10 ,),


              RoundButton(Title: "Please Try Again", onpresed:(){Navigator.pop(context);Get.delete<CartService>();}),
              TextButton(onPressed:(){Get.off(()=> const maintabview()); Get.delete<CartService>(); }, child:Text("Back to home", textAlign:TextAlign.center,style:TextStyle(color:Tcolor.primarytext, fontSize:18, fontWeight:FontWeight.w600),) )
            ],
          ),
        ),
      ),
    );
  }
}
