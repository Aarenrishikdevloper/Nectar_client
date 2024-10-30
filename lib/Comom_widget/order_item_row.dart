import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/OrderDeletemodel.dart';
import 'package:nectar/models/Orderproducts.dart';

class orderRow extends StatelessWidget {
  final OrderProduct? item;
  final VoidCallback ontap;
  const orderRow({super.key, this.item, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin:EdgeInsets.symmetric(vertical:4),
        padding:EdgeInsets.symmetric(vertical:15, horizontal:15),
        decoration:BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(5),
          boxShadow: const[BoxShadow(color:Colors.black12, blurRadius:2)],

        ),

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:item?.image as String,
                  width:80 ,
                  height:65,
                  fit:BoxFit.contain,
                ),
                const SizedBox(width:15,),
                Expanded(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(
                        item!.name as String,
                        style:TextStyle(
                          color:Tcolor.primarytext,
                          fontSize:16,
                          fontWeight: FontWeight.w700
                        ) ,
                      ),
                      SizedBox(height:2),
                      Text(
                          "${item!.unitValue} ${item!.unitName} Price",
                           style:TextStyle(
                             color:Tcolor.secoundarytext,
                             fontSize:16,
                             fontWeight:FontWeight.w500
                           ),


                      ),
                      SizedBox(height:10,),
                      
                      Row(
                        children: [
                          Text(
                            "QTY :",
                            style:TextStyle(
                              color:Tcolor.primarytext,
                              fontSize:14,
                              fontWeight:FontWeight.w500
                            ),
                          ),
                          SizedBox(width:8,),
                          Text(
                              item!.qty.toString(),
                              style:TextStyle(
                                color:Tcolor.primarytext,
                                fontSize:14,
                                fontWeight:FontWeight.w500
                              ),
                          ),
                          SizedBox(width:5,),
                          Text(
                            "x",
                            style:TextStyle(
                              color:Tcolor.primarytext,
                              fontSize:16,
                              fontWeight:FontWeight.w500
                          ),
                          ),
                          const SizedBox(width:5,),
                          Text(
                            "₹${item!.price!.toInt()}",
                            style:TextStyle(
                                color:Tcolor.primarytext,
                                fontSize:14,
                                fontWeight:FontWeight.w500
                            ),
                          ),
                        const Spacer(),
                          Text(
                            "₹${item!.price!.toInt() * item!.qty!.toInt()}",

                            style:TextStyle(
                                color:Tcolor.primarytext,
                                fontSize:14,
                                fontWeight:FontWeight.w500
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                )
              ],
            ),
            Padding(
                padding:EdgeInsets.only(top:8),
                child:RoundButton(Title: "Write a Review", onpresed:ontap, )
            )
          ],
        ),

        ),
      );



  }
}
