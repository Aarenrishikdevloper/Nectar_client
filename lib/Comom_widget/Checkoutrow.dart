import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/commons/themedata.dart';

class Checkoutrow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onPressed;
  const Checkoutrow({super.key, required this.title, required this.value,   this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          child: Padding(
            padding:EdgeInsets.symmetric(vertical:15),
            child:Row(
              children: [
                Text(title,style:TextStyle(color:Tcolor.secoundarytext, fontSize:18, fontWeight:FontWeight.w600),),
                Expanded(
                  child:Text(
                    value,
                    textAlign:TextAlign.end,
                    style:TextStyle(
                      color:Tcolor.primarytext,
                      fontSize:16,
                      fontWeight:FontWeight.w600
                    ),

                  ),
                ), 
                const SizedBox(width:15,), 
                Image.asset("assets/img/next.png", height:15, color:Tcolor.primarytext ,)
              ],
            ),
          ),
        ),
        const Divider(height:1, color:Colors.black26,)
      ],
    );
  }
}
