import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';

class  RoundButton extends StatelessWidget {
  final String Title;
  final VoidCallback onpresed;
  final Color? bgcolor;
  final double?height;
  const RoundButton ({super.key, required this.Title, required this.onpresed, this.bgcolor, this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed:onpresed,
        height:height??60,
        shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(17)) ,
       minWidth: double.maxFinite,
      elevation: 0.1,
      color: bgcolor?? Tcolor.primary,
      child: Text(
        Title,
        style:TextStyle(
          color:Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600
        )
      ),
    );
  }
}

class  RoundIconButton extends StatelessWidget {
  final String Title;
  final VoidCallback onpresed;
  final String icon;
  final Color bgcolor;
  const RoundIconButton ({super.key, required this.icon, required this.Title, required this.onpresed,  required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed:onpresed,
      height: 60,
      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(17)) ,
      minWidth: double.maxFinite,
      elevation: 0.1,
      color: bgcolor,
      child: Row(
        children: [
          Image.asset(icon, width:20, height: 20, ),
          const SizedBox(width:30,),
          Text(
              Title,
              style:TextStyle(
                  color:Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}

