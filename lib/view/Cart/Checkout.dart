import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/Checkoutrow.dart';
import 'package:nectar/commons/constants.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/models/Promomodel.dart';
import 'package:nectar/view/Cart/Error.dart';
import 'package:nectar/view/Cart/Sucess.dart';
import 'package:nectar/view/account/PromoCode.dart';
import 'package:nectar/view/account/adress_screen.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../commons/utils.dart';
import '../../view_model/addcartservice.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final cartservive = Get.put(CartService());

  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlesucess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _failure);

    super.initState();
  }

  void createorder() {
    var deliveryprice = cartservive.deliverytype.value == "collection" ? 0 : 20;
    var discountprice = cartservive.promobj.value.promoCode != null ? cartservive.promobj.value.offerPrice:0.00;
    var finalprice = double.parse(cartservive.pricevalue(deliveryprice,discountprice ));
    if (cartservive.deliveryobj.value.id!.isEmpty &&
        cartservive.deliverytype.value == "Delivery") {
      Get.snackbar("Error", "Address is required in delivery mode");
      return;
    }
    if(cartservive.totalPrice < cartservive.promobj.value.minOrderPrice){
      Get.snackbar("Discount Unavailable", "You are not eligible for discount");
       cartservive.promobj.value = Promo();
      return;
    }


   var  options = {
      'key': constants.api_key,
      'amount': (finalprice * 100).toInt(), // Amount in paise
      'name': 'Nectar',
      'description': 'Payment for groceries',
      'prefill': {
        'contact': cartservive.deliveryobj.value.mobileNumber,
        'email': 'example@example.com',
      },
      'method': {
        'upi': true,
        'netbanking': true,
        'card': true,
        'wallet': true,
        'emi': false,
        'paylater': false,
        'credit': false,
      },
      'notes': {
        'delivery_price': cartservive.deliverytype.value == "Delivery"
            ? "20"
            : "0",
        "delivery_option": cartservive.deliverytype.value.toString()
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _handlesucess(PaymentSuccessResponse response) {
    var deliveryprice = cartservive.deliverytype.value == "Collection" ? 0.00 : 20.00;
    var discountprice = cartservive.promobj.value.promoCode != null ? cartservive.promobj.value.offerPrice:0.00;

    cartservive.createorderOnline(cartservive.Cartlist.map((item) =>
    ({
      'productid': item.productid,
      'qty': item.qty
    })).toList(), double.parse(cartservive.pricevalue(deliveryprice,discountprice)), deliveryprice,
        cartservive.deliveryobj.value.id, deliveryprice, discountprice);
    Get.delete<CartService>();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Sucess()));
  }

  void _failure(PaymentFailureResponse response) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ErrorPage()));
  }

  @override
  Widget build(BuildContext context) {
    return


       SingleChildScrollView(
         child: Container(
           padding:EdgeInsets.all(20),
         
           decoration:BoxDecoration(
             borderRadius:BorderRadius.circular(30),
             color:Colors.white,
           ),
           child: Obx(() {
         
         
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  Padding(
                    padding:EdgeInsets.symmetric(vertical:15),
                    child:Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Checkout", style:TextStyle(
                          color:Tcolor.primarytext,
                          fontSize:20,
                          fontWeight:FontWeight.w700,
                        ),),
                        InkWell(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child:Image.asset(
                            "assets/img/close.png",
                            width:15,
                            height:15,
                            color:Tcolor.primarytext,
                          )
                        )
                      ],
                    ),
                  ),
                const Divider(
                   color:Colors.black26,
                   height:1,
                 ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Text("Delivery Type", style: TextStyle(color: Tcolor
                              .secoundarytext,
                              fontSize: 18,
                              fontWeight: FontWeight
                                  .w600),),
                          const Spacer(),
                          CupertinoSegmentedControl(
                            children: const {
                              "Delivery": Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("Delivery"),),
                              "collection": Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("Collection"),),
                            },
                            selectedColor: Tcolor.primary,
                            groupValue: cartservive.deliverytype.value,
                            onValueChanged: (sobj) {
                              cartservive.deliverytype.value = sobj;
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1,
                ),
                if(cartservive.deliverytype.value == "Delivery")
                  Checkoutrow(
                    title: "Delivery to",
                    value: cartservive.deliveryobj.value.name == ""
                        ? "Select Method"
                        : cartservive.deliveryobj.value.name as String,
                    onPressed: () {
                      Get.to(() =>
                          AdressScreen(didselect: (aobj) {
                            cartservive.deliveryobj.value = aobj;
                          },));
                    },
                  ),
         
                 const Divider(color:Colors.black12,height:1 ,),
                Checkoutrow(title: "Promo Code",
                   value: (cartservive.promobj.value.promoCode ?? "") != ""?cartservive.promobj.value.promoCode:"Pick discount",
                    onPressed:(){
                     Get.to(
                         ()=>Promocode(
                           didSelect: (pobj){
         
                               cartservive.promobj.value = pobj;
         
         
         
         
         
         
                           },
                         )
                     );
                    } ,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, right: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  color: Tcolor.secoundarytext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Expanded(
                                child: Text(
                                  utils.formatPrice(cartservive.totalPrice),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Tcolor.secoundarytext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
         
                                )
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Delivery Cost",
                              style: TextStyle(
                                  color: Tcolor.secoundarytext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Obx(() {
                              return Expanded(
                                  child: Text(
                                    cartservive.deliverytype.value == "Delivery"
                                        ? utils.formatPrice(20)
                                        : utils.formatPrice(0),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Tcolor.secoundarytext,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
         
                                  )
                              );
                            })
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Discount",
                              style: TextStyle(
                                  color: Tcolor.secoundarytext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Expanded(
                                child: Text(
                                cartservive.promobj.value.promoCode != null ?  " - ${utils.formatPrice(cartservive.promobj.value.offerPrice)}":"- ${utils.formatPrice(0.00)}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
         
                                )
                            )
                          ],
                        ),
                      ),
         
                    ],
                  ),
                ),
         
                Obx(() {
                  var deliveryprice = cartservive.deliverytype.value == "collection" ? 0 : 20;
                  var discountprice = cartservive.promobj.value.promoCode != null ? cartservive.promobj.value.offerPrice:0.00;
                  var finalprice = cartservive.pricevalue(deliveryprice,discountprice);
                  return Checkoutrow(
                      title: "Final Total", value:finalprice);
                }),
         
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Tcolor.secoundarytext,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),
                        children: [
                          TextSpan(text: "By Continuing you agree to our "),
         
                          TextSpan(
                            text: "Terms",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
         
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
         
                          ),
                        ]
                    ),
                  ),
                ),
         
                Obx(() {
                  return RoundButton(Title: cartservive.isloading.value == true
                      ? "Processing..."
                      : "Place Order",
                    onpresed: () {
                      createorder();
                    },
                    bgcolor: cartservive.isloading.value == true ? Tcolor
                        .disablecolor : Tcolor.primary,height:60,);
                }),
                SizedBox(height: 15,),
         
              ],
            );
                 }),
         ),
       );

  }
}
