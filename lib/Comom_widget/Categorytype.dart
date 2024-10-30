import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/commons/constants.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/explore/exploreview.dart';

class categorycart extends StatelessWidget {
  final GroceryCategory category;
  final Color color;

  const categorycart({super.key, required this.category, required this.color});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Get.to(()=>Exploreview(cat:category.name,));
      },
      child: Container(
        width:250,
        margin: EdgeInsets.symmetric(horizontal:8),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                ClipRect(child: Image.asset(category.imagePath, width:40, height:40, fit:BoxFit.contain,)),
                SizedBox(width:15,), 
                Expanded(
                  child: Text(category.name, style:TextStyle(color:Tcolor.primary, fontSize:16, fontWeight:FontWeight.w700),),
                )
              ],
             
            )
          ],
        ),
      ),
    );
  }
}
