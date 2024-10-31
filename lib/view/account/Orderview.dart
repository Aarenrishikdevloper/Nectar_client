


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nectar/Comom_widget/orderrow.dart';
import 'package:nectar/Comom_widget/popout.dart';
import 'package:nectar/Comom_widget/write_review.dart';
import 'package:nectar/models/order.dart';
import 'package:nectar/view_model/OederController.dart';

import '../../Comom_widget/order_item_row.dart';
import '../../commons/themedata.dart';
import '../../commons/utils.dart';
import '../../view_model/OrderDetailview.dart';

class Orderview extends StatefulWidget {
  final Orders item;
  final int index;

  const Orderview({super.key, required this.item, required this.index,});

  @override
  State<Orderview> createState() => _OrderviewState();
}

class _OrderviewState extends State<Orderview> {
  final orderdetailService = Get.put(Orderdetailview());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderdetailService.getorderDetails(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          "My Order Details",
          style: TextStyle(
              color: Tcolor.primarytext,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/img/back.png',
            width: 20,
            height: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        return orderdetailService.isloading.value == false
            ? SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Order Id: #${widget.index + 1}",
                                style: TextStyle(
                                    color: Tcolor.primarytext,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              utils.getorderPayment((orderdetailService
                                      .Orderdetails.value?.paymentStatus)
                                  .toString()),
                              style: TextStyle(
                                  color: utils.getorderColorPayment(
                                      (orderdetailService.Orderdetails.value
                                              ?.paymentStatus)
                                          .toString()),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat('yyyy-MM-dd - hh:mm a').format(
                                    orderdetailService
                                        .Orderdetails.value!.createdAt!
                                        .toLocal()),
                                style: TextStyle(
                                    color: Tcolor.secoundarytext, fontSize: 12),
                              ),
                            ),
                            Text(
                              utils.getorderstatus(orderdetailService
                                  .Orderdetails.value!.orderStatus as String),
                              style: TextStyle(
                                color: utils.getorderColor(orderdetailService
                                    .Orderdetails.value!.orderStatus as String),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (orderdetailService.Orderdetails.value?.postalcode !=
                            "")
                          Text(
                            "${orderdetailService.Orderdetails.value?.address ?? ""}, ${orderdetailService.Orderdetails.value?.city ?? ""}, ${orderdetailService.Orderdetails.value?.state ?? ""} ${orderdetailService.Orderdetails.value?.postalcode ?? ""}  ",
                            style: TextStyle(
                                color: Tcolor.secoundarytext, fontSize: 16),
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "Delivery Type: ",
                              style: TextStyle(
                                  color: Tcolor.primarytext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                orderdetailService
                                    .Orderdetails.value?.deliveryType as String,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Tcolor.primarytext, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "Payment Type: ",
                              style: TextStyle(
                                  color: Tcolor.primarytext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                orderdetailService
                                    .Orderdetails.value?.paymentType as String,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Tcolor.primarytext, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height:4,),

                        Obx(() {
                          return orderdetailService.isloading.value == false
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0),
                                  itemBuilder: (context, index) {
                                    var pobj = orderdetailService
                                        .Orderdetails.value?.product![index];
                                    return orderRow(
                                      item: pobj,
                                      showreviewbutton:orderdetailService.Orderdetails.value!.orderStatus == "delivered",
                                      ontap: () {

                                        Navigator.push(
                                            context,
                                            PopoutLayout(
                                                child: WriteReview(
                                              prodId:pobj?.id as String,
                                            )));
                                      },
                                    );
                                  },
                                  itemCount: orderdetailService
                                      .Orderdetails.value?.product!.length,
                                )
                              : SizedBox();
                        }),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius:2),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Amount: ",
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(widget.item.totalPrice)} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Delivery Cost: ",
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(widget.item.deliveryPrice)} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),


                                  ],

                                ),
                                const SizedBox(height:4,),
                                Row(
                                  children: [
                                    Text(
                                      "Discount: ",
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(widget.item.discount.toDouble())} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),


                                  ],

                                ),
                                SizedBox(height:8,),
                                Container(
                                  width:double.maxFinite,
                                  height:1,
                                  color:Colors.black12,
                                ),
                                SizedBox(height:8,),
                                Row(
                                  children: [
                                    Text(
                                      "Total: ",
                                      textAlign:TextAlign.right,
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${utils.formatPrice(widget.item.userPayPrice.toDouble())} ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),


                                  ],

                                ),

                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ))
            : SizedBox();
      }),
    );
  }
}
