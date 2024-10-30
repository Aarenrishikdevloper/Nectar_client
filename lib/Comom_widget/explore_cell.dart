import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/commons/constants.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/explore/exploreview.dart';

class ExploreCell extends StatelessWidget {
  final GroceryCategory pobj; 
  final Color color;
  const ExploreCell({super.key, required this.pobj, required this.color});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap:()=>Get.to(()=> Exploreview(cat:pobj.name)),
      child: Container(
        padding: EdgeInsets.all(15), 
        decoration: BoxDecoration(
          border: Border.all(color:color, width: 1), 
          color:color, 
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset(
                 pobj.imagePath,
                 width: 120,
                 height: 90,
                 fit: BoxFit.contain,
               )
             ],
           ),
            const Spacer(),
            Text(pobj.name, textAlign:TextAlign.center,style:TextStyle(color:Tcolor.primarytext,fontSize:16, fontWeight:FontWeight.w700),),
            const Spacer()
          ],
        ),
      ),
      
    );
  }
}
