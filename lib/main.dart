import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/Splash.dart';





Future<void> main()async{

 WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());

}
void configLoading(){
  EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
       ..loadingStyle =EasyLoadingStyle.custom
       ..indicatorSize =45.0
      ..radius = 5.0
      ..progressColor = Tcolor.primarytext
      ..backgroundColor = Tcolor.primary
      ..indicatorColor = Colors.yellow
      ..textColor = Tcolor.primarytext
      ..userInteractions = false
      ..dismissOnTap=false;

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Online Groceries',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Gilroy",
        colorScheme: ColorScheme.fromSeed(seedColor: Tcolor.primary),
        useMaterial3:false,

      ),
      defaultTransition: Transition.noTransition,
      home: const splashscreen(),
      builder: (context, child){
        return FlutterEasyLoading(child: child);
    },
    );
  }
}


