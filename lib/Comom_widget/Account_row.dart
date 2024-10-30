import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';

class Accountrow extends StatelessWidget {
  final String title; 
  final String icon;
  final VoidCallback onClick;
  const Accountrow({super.key, required this.title, required this.icon, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onClick,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:20, horizontal:20), 
            child: Row(
              children: [
                Image.asset(icon, width:20, height:20,),
                SizedBox(width:15,),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Tcolor.primarytext,
                      fontSize:18,
                      fontWeight:FontWeight.w600
                    ),

                  ),
                ),
                SizedBox(width:15,), 
                Image.asset("assets/img/next.png", height:15,color:Tcolor.primarytext,)
              ],
            ),
             
          ),
        ),
        const Divider(color:Colors.black26, height: 1,)
      ],
    );
  }
}
