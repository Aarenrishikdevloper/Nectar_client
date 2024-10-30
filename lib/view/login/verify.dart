import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/login/Login.dart';
import 'package:nectar/view/login/passwordset.dart';
import 'package:nectar/view_model/Forgotpasswordservice.dart';

class verify extends StatefulWidget {
  final String email;

  verify({super.key, required this.email});

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  final TextEditingController controller = TextEditingController();
  final service = Get.put(ForgotpasswordService());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);


    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            "assets/img/bottom_bg.png",
            width: MediaQuery
                .sizeOf(context)
                .width,
            height: MediaQuery
                .sizeOf(context)
                .height,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      Text(
                        "Enter Your 4  digit code ",
                        style: TextStyle(
                            color: Tcolor.primarytext,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      lineInput(
                        title: "Code",
                        placeholder: "Enter Your Code",
                        controller: controller,
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: media.width * 0.3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              service.getverificationCode(widget.email);
                            },
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                  color: Tcolor.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Obx(() {
                            return InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () async {
                                if (!service.isloading.value) {
                                  final result = await service.verificationCode(
                                      widget.email, controller.text);
                                  if (result) {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            Passwordset(email: widget.email,)
                                    ));
                                  }
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color:service.isloading.value == false? Tcolor.primary:Tcolor.disablecolor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Image.asset(
                                  "assets/img/next.png",
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            );
                          })
                        ],
                      )
                    ],
                  )),
            ),
          ),
        )
      ],
    );
  }
}
