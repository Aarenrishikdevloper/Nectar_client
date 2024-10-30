import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/Home/home.dart';
import 'package:nectar/view/Maintabview/maintabview.dart';

class Sucess extends StatelessWidget {
  const Sucess({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: media.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset("assets/img/order_accpeted.png", width:media.width * 0.7,),
              const SizedBox(
                height: 10,
              ),

              Text("Your Order has been accepted", textAlign:TextAlign.center, style:TextStyle(color:Tcolor.primarytext, fontSize:28, fontWeight:FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
              Text("Your items has been placed and is on\nit's way of being processed", textAlign:TextAlign.center,style:TextStyle(color:Tcolor.secoundarytext, fontSize:16, fontWeight:FontWeight.w600),),
              const SizedBox(height:10,),
              RoundButton(Title: "Track Order", onpresed:(){}),
              TextButton(onPressed:()=>Get.off(()=> const maintabview()), child:Text("Back to home", textAlign:TextAlign.center,style:TextStyle(color:Tcolor.primarytext, fontSize:18, fontWeight:FontWeight.w600),) )

            ],
          ),
        ),
      ),
    );
  }
}
