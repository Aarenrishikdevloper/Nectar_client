import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/orderrow.dart';
import 'package:nectar/models/order.dart';
import 'package:nectar/view_model/OederController.dart';
import 'package:nectar/models/order.dart';
import '../../commons/themedata.dart';

import 'Orderview.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}


class _OrderState extends State<Order> {
  final ordercontroller = Get.put(OrderController());

  var newstatus;
  @override
  void initState() {
    ordercontroller.getorder();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<OrderController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text("My Orders", style: TextStyle(color: Tcolor.primarytext,
                fontSize: 20,
                fontWeight: FontWeight.w700),),
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
          body: ordercontroller.isloading.value == false ?ordercontroller.orders.isEmpty?Center(
             child:Text("No Any Order Placed", style:TextStyle(
               color:Tcolor.primarytext,
               fontSize:20,
               fontWeight:FontWeight.w700
             )),
          ):

                  Obx(() {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      itemCount: ordercontroller.orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = ordercontroller.orders[index];
                        return Orderrow(item: item, Index: index,status:newstatus, ontap: () {
                          Get.to(() => Orderview(item: item, index: index));
                        },);
                      },

                    );
                  }) :null,





      );
    });
  }
}
