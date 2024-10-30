import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/login/verify.dart';
import 'package:nectar/view_model/Forgotpasswordservice.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final TextEditingController controller = TextEditingController();
  final service = Get.put(ForgotpasswordService());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset("assets/img/bottom_bg.png", width: MediaQuery
                .sizeOf(context)
                .width, height: MediaQuery
                .sizeOf(context)
                .height, fit: BoxFit.cover,),
          ),
          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/img/back.png",
                    width: 20,
                    height: 20,

                  ),
                ),

              ),
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/color_logo.png', width: 40,),
                          ],
                        ),
                        SizedBox(height: media.width * 0.15,),
                        Text("Forgot Password", style: TextStyle(
                            color: Tcolor.primarytext,
                            fontSize: 26,
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: media.width * 0.03,),
                        Text("Enter your email", style: TextStyle(
                            color: Tcolor.secoundarytext,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),),
                        SizedBox(height: media.width * 0.1,),
                        lineInput(title: "Email",
                            placeholder: "Enter your email address",
                            controller: controller,
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(height: media.width * 0.05,),
                        Obx(() {
                          return RoundButton(
                            Title:service.isloading.value == false? "Submit":"...Submitting",
                            onpresed: () async{
                              final result = await service.getverificationCode(controller.text);
                              if(result){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>verify(email:controller.text,)));
                              }
                            },
                            bgcolor:service.isloading.value == false?Tcolor.primary:Tcolor.disablecolor,
                          );
                        })
                      ],
                    ),
                  ),
                ),
              )
          ),
        ]
    );
  }
}
