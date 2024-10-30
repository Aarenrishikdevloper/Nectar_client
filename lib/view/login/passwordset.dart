import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/login/Login.dart';
import 'package:nectar/view_model/Forgotpasswordservice.dart';

class Passwordset extends StatefulWidget {
  final String email;

  Passwordset({super.key, required this.email});

  @override
  State<Passwordset> createState() => _PasswordsetState();
}

class _PasswordsetState extends State<Passwordset> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
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
              )
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
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/img/color_logo.png", width: 40,),


                            ],

                          ),
                          SizedBox(height: media.width * 0.15,),
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 26,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: media.width * 0.03,),
                          Text(
                            "Enter Your New password ",
                            style: TextStyle(
                                color: Tcolor.secoundarytext,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(
                            height: media.width * 0.1,
                          ),
                          lineInput(
                            title: "New password",
                            placeholder: "Enter your New Password",
                            obsecuretext: true,
                            controller: newpassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 Chracters";
                              }
                              if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
                                  .hasMatch(value)) {
                                return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: media.width * 0.1,),
                          lineInput(
                            title: "Confirm password",
                            placeholder: "Conirm Your Password",
                            obsecuretext: true,
                            controller: confirmpassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Confirm Your Password";
                              }
                              if (value != newpassword.text) {
                                return "passwords do not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: media.width * 0.05,),
                          Obx(() {
                            return RoundButton(Title:service.isloading.value == false?  "Submit":"...Submitting", onpresed: () async{
                              final result = await service.changepassword(newpassword.text, widget.email);
                                if(result){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>const Login()));
                              }
                            },bgcolor:service.isloading.value == false?Tcolor.primary:Tcolor.disablecolor ,);
                          }),


                        ],
                      ),
                    ),
                  ),
                ),
              )
          )
        ]
    );
  }
}
