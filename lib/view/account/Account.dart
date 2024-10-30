import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Account_row.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/account/Order.dart';
import 'package:nectar/view/account/PromoCode.dart';
import 'package:nectar/view/account/adress_screen.dart';
import 'package:nectar/view/account/my_details.dart';
import 'package:nectar/view_model/UserService.dart';

import 'package:nectar/view_model/auth.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final authservice = Get.put(Userservice());
  final service = Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authservice.Userdetails();
  }

  @override
  void dispose() {
    Get.delete<AuthViewModel>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: authservice.isloading.value == false ? SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.asset('assets/img/u1.png', width: 60,
                          height: 60,),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Obx(() {
                                    return Text(
                                      authservice.userdetails.value
                                          ?.name as String,
                                      style: TextStyle(
                                          color: Tcolor.primarytext,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700

                                      ),


                                    );
                                  }),
                                  SizedBox(width: 8,),
                                  Icon(
                                      Icons.edit,
                                      color: Tcolor.primarytext,
                                      size: 18
                                  )
                                ],
                              ),
                              Obx(() {
                                return Text(authservice.userdetails.value
                                    ?.email as String, style: TextStyle(
                                    color: Tcolor.secoundarytext,
                                    fontSize: 16),);
                              }),
                            ],
                          )
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.black26, height: 1,),
                Accountrow(
                  title: "My Orders",
                  icon: "assets/img/a_order.png",
                  onClick: () {
                    Get.to(() => const Order());
                  },
                ),
                Accountrow(
                  title: "My Details",
                  icon: "assets/img/a_my_detail.png",
                  onClick: () {
                    Get.to(() =>
                        MyDetails(user: authservice.userdetails.value,));
                  },
                ),
                Accountrow(
                  title: "Delivery Address",
                  icon: "assets/img/a_delivery_address.png",
                  onClick: () {
                    Get.to(() => const AdressScreen());
                  },
                ),

                Accountrow(
                  title: "Promo Code",
                  icon: "assets/img/a_promocode.png",
                  onClick: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Promocode()));
                  },
                ), Accountrow(
                  title: "Notifications",
                  icon: "assets/img/a_noitification.png",
                  onClick: () {},
                ),
                Accountrow(
                  title: "Help",
                  icon: "assets/img/a_help.png",
                  onClick: () {},

                ),
                Accountrow(
                  title: "About",
                  icon: "assets/img/a_about.png",
                  onClick: () {},

                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          service.logout();
                        },
                        height: 60,
                        minWidth: double.maxFinite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19)
                        ),
                        elevation: 0.1,
                        color: const Color(0xffF2F3F2),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Log Out", style: TextStyle(
                                    color: Tcolor.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),),

                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Image.asset(
                                "assets/img/logout.png", width: 20,
                                height: 20,),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                )


              ],
            ),
          ),
        ) : null,
      );
    });
  }
}
