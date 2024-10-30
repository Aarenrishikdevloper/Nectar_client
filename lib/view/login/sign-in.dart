import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/login/Login.dart';

import '../../view_model/auth.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final authservice = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/img/bottom_bg.png', height: MediaQuery
                    .sizeOf(context)
                    .height, width: MediaQuery
                    .sizeOf(context)
                    .width, fit: BoxFit.cover,)
              ],

            ),
            Image.asset('assets/img/sign_in_top.png', width: MediaQuery
                .sizeOf(context)
                .width),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .sizeOf(context)
                          .width * 0.7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Get Your groceries\nwith nectar", style: TextStyle(
                            color: Tcolor.primarytext,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,

                          ),),

                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundButton(
                        Title: "Sign In With Email", onpresed: () {
                        Get.to(() => const Login());
                      }, bgcolor: const Color(0xff5383EC),),

                    ),

                    const SizedBox(height: 25,),

                    Text("Or Connect With social media", style: TextStyle(
                        color: Tcolor.secoundarytext,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(() {
                        return RoundIconButton(
                            icon: "assets/img/google_logo.png",
                            Title: authservice.isloading == false
                                ? "Continue With Google"
                                : "loging in With Goggle",
                            onpresed: () {

                            },
                            bgcolor: const Color(0xff5383EC));
                      }),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundIconButton(icon: "assets/img/fb_logo.png",
                          Title: "Continue With facebook",
                          onpresed: () {},
                          bgcolor: const Color(0xff4a66Ac)),
                    ),
                    SizedBox(height: 15,),

                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
