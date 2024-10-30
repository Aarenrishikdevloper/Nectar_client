import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/order.dart';

class Orderrow extends StatelessWidget {
  final Orders item;
  final int Index;
  final VoidCallback ontap;
 final String?status;

  const Orderrow({super.key, required this.item, required this.Index, required this.ontap, this.status});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:ontap ,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 2)
            ],
            color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Order No:#",
                  style: TextStyle(
                    color: Tcolor.primarytext,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,

                  ),
                ),
                Expanded(
                  child: Text(
                    (Index + 1).toString(),
                    style: TextStyle(
                        color: Tcolor.primarytext,
                        fontSize: 16,
                        fontWeight: FontWeight.w700

                    ),

                  ),
                ),
                Text(
                 status != null? utils.getorderstatus(status!):utils.getorderstatus(item.orderStatus),
                  style: TextStyle(
                      color:utils.getorderColor(item.orderStatus),
                      fontSize: 16,
                      fontWeight: FontWeight.w700

                  ),
                )
              ],
            ),

            Text(
              DateFormat('yyyy-MM-dd - hh:mm a').format(
                  item.createdAt.toLocal()),
              style: TextStyle(
                  color: Tcolor.secoundarytext,
                  fontSize: 12
              ),
            ),
            SizedBox(height: 8,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl:item.Image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Items: ",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),


                          ),
                          Expanded(
                            child: Text(
                              item.Items.map((i)=>i.toString()).join(", "),
                              style: TextStyle(
                                  color: Tcolor.primarytext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),

                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Delivery Type: ",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),


                          ),
                          Expanded(
                            child: Text(
                              item.deliveryType == "collection"
                                  ? "Collection"
                                  : "Delivery",
                              style: TextStyle(
                                  color: Tcolor.primarytext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),

                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment Type: ",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),


                          ),
                          Expanded(
                            child: Text(
                              item.paymentType,
                              style: TextStyle(
                                  color: Tcolor.primarytext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),

                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment Status: ",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),


                          ),
                          Expanded(
                            child: Text(
                            utils.getorderPayment(item.paymentStatus),
                              style: TextStyle(
                                  color:utils.getorderColorPayment(
                                      item.paymentStatus),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              ),

                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }


}