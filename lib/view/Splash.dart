
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view_model/splash_service.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  final SplashService splashService = Get.put(SplashService());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      splashService.navigatewelcomescreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.primary,
      body: Center(
        child: Image.asset('assets/img/splash_logo.png', width:MediaQuery.sizeOf(context).width*0.7, ),
      ),
    );
  }
}
