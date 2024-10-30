import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/view/login/sign-in.dart';

import 'Login.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: [
          Image.asset("assets/img/welcom_bg.png", width: MediaQuery.sizeOf(context).width, height:MediaQuery.sizeOf(context).height, fit:BoxFit.cover,),  
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                Image.asset('assets/img/app_logo.png', width:60, height:60,),
                SizedBox(height: 8,),
                 const Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome\nto our store", style:TextStyle(color:Colors.white, fontSize:48, fontWeight:FontWeight.w600),),

                  ],
                ),
                SizedBox(height: 8,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Get your grocery as fast as one hour", style:TextStyle(color:Color(0xffFCFCFC).withOpacity(0.5), fontSize:16, fontWeight:FontWeight.w500),),

                  ],
                ),
                const SizedBox(height:20,),
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal:20),
                  child: RoundButton(
                    Title: "Get Started",
                    onpresed: (){
                     Get.off(()=>const Login());
                    },
                  ),
                ),
                SizedBox(height:45 ,)

              ],
            ),
          )
        ], 
        
      )

    );
  }
}
