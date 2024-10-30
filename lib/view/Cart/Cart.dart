import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/CartItems.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/cartmodel.dart';
import 'package:nectar/view/Cart/Checkout.dart';

import '../../commons/themedata.dart';
import '../../view_model/addcartservice.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final cartservive = Get.put(CartService());


  @override
  void initState() {
    cartservive.fetchdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<CartService>();
  }

  String getPrice(double price, int qty) {
    var pricefinal = (price) *
        qty;
    final cost = utils.formatPrice(pricefinal);
    return cost.replaceAll('₹', '');
  }
  void showCheckout(){
    showModalBottomSheet(
        context: context,
        isDismissible:false,
        isScrollControlled:true,
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.vertical(
            top:Radius.circular(30),
          )
        ),
        builder:(context){
          return const Checkout();
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor:Colors.white,
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text("Cart", style: TextStyle(color: Tcolor.primarytext,
                fontSize: 20,
                fontWeight: FontWeight.w700),),
            centerTitle: true,


          ),
          body: cartservive.isloading.value == false ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView.separated(
                padding: EdgeInsets.all(20),
                itemCount: cartservive.Cartlist.value.length,
                separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.black26,),
                itemBuilder: (BuildContext context, int index) {
                  var item = cartservive.Cartlist.value[index];
                  return Cartitems(cobj: item, onDelete: () {
                    cartservive.deleteitem(item.productid);
                  },
                    onIncqty: () {
                      int newqty = item.qty + 1;

                      double cost = item.originalprice * newqty;
                      cartservive.Cartlist.value[index] = CartModel(
                          productid: item.productid,
                          name: item.name,
                          qty: newqty,
                          price: cost,
                          image: item.image,
                          unitValue: item.unitValue,
                          unitName: item.unitName,
                          originalprice: item.originalprice
                      );
                      cartservive.Cartlist.refresh();


                      cartservive.serviceCallEditqtyCart(
                          item.productid, newqty, cost);
                    },
                    ondeccqty: () {
                      var newqty;
                      var cost;
                      if (item.qty > 1) {
                        newqty = item.qty - 1;
                        cost = item.originalprice * newqty;
                      }
                      cartservive.Cartlist[index] = CartModel(
                          productid: item.productid,
                          name: item.name,
                          qty: newqty,
                          price: cost,
                          image: item.image,
                          unitValue: item.unitValue,
                          unitName: item.unitName,
                          originalprice: item.originalprice
                      );
                      cartservive.Cartlist.refresh();


                      cartservive.serviceCallEditqtyCart(
                          item.productid, newqty, cost);
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: cartservive.Cartlist.isNotEmpty?
                    MainAxisAlignment.end:MainAxisAlignment.center,
                    children: [
                     cartservive.Cartlist.isNotEmpty? MaterialButton(
                        height: 60,
                        onPressed: showCheckout,
                        elevation: 0.1,
                        color: Tcolor.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19)
                        ),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Go to Checkout", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5),


                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: Text(
                                utils.formatPrice(cartservive.totalPrice),
                                style: const TextStyle(color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),),
                            )
                          ],

                        ),


                      ):Text("Your Card is Empty", style: TextStyle(color:Tcolor.primarytext, fontWeight:FontWeight.w700, fontSize:20),)
                    ],
                  );
                }),
              )
            ],

          ) : null
      );
    });

  }


}


