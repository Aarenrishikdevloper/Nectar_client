import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';

class section  extends StatelessWidget {
  final String title;
  final EdgeInsets?padding;
  const section ({super.key, required this.title, required this.padding });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:padding, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Text(title, style:TextStyle(color:Tcolor.primarytext, fontSize:24, fontWeight:FontWeight.w600),),
          TextButton(onPressed: (){}, child:Text("See All", style:TextStyle(color:Tcolor.primary, fontSize:16, fontWeight:FontWeight.w600),))
        ],
      ),
    );
  }
}
