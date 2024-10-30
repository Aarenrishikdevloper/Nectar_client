import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';

import '../models/Favorite.dart';


class FavRow extends StatelessWidget {
  const FavRow({super.key, required this.pobj});
  final Favorite pobj;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:10),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: pobj.image![0],
                  width:60,
                  height:60,
                  fit:BoxFit.contain
                ), 
                SizedBox(
                  width: 15,
                ), 
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Text(pobj.name, style:TextStyle(fontSize:16, fontWeight:FontWeight.w700, color:Tcolor.primarytext)), 
                      const SizedBox(height:2,), 
                      Text("${pobj.unitValue} ${pobj.unitName} price", style:TextStyle(fontSize:14, color:Tcolor.secoundarytext, fontWeight:FontWeight.w500),), 

                    ],
                    
                  ),
                ),
                const SizedBox(width:8),
                Text( utils.formatPrice(pobj.price), style:TextStyle(fontSize:18,  color:Tcolor.primarytext)),
                const SizedBox(width:15),
                Image.asset('assets/img/next.png', height:15, color:Tcolor.primarytext,)

                

              ],
            ),
          ),

        ),
        const Divider(color:Colors.black26, height:1,),
      ],
    );
  }
}
