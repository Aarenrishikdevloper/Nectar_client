import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/login/Login.dart';
import 'package:nectar/view_model/auth.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final TextEditingController emailcontrooler = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final AuthViewModel Authcontroller = Get.put(AuthViewModel());
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontrooler.dispose();
    password.dispose();
    namecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset('assets/img/bottom_bg.png',
              width: MediaQuery
                  .sizeOf(context)
                  .width,
              height: MediaQuery
                  .sizeOf(context)
                  .height,
              fit: BoxFit.cover),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/color_logo.png",
                              width: 40,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.15,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 26,
                              color: Tcolor.primarytext,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.03,
                        ),
                        Text(
                          "Enter Your Credentials to continue",
                          style: TextStyle(
                              fontSize: 16,
                              color: Tcolor.secoundarytext,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.1,
                        ),
                        lineInput(
                          title: "Name",
                          placeholder: "Enter Your Username",
                          controller: namecontroller,
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return "Please Enter a valid name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.07,
                        ),
                        lineInput(
                          title: "Email",
                          placeholder: "Enter Your Email Address",
                          controller: emailcontrooler,
                          validator: (value) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value!)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.07,
                        ),
                        Obx(() {
                          return lineInput(
                            title: "Password",
                            placeholder: "Enter Your Password",
                            obsecuretext: !Authcontroller.isShowpassword.value,
                            right: IconButton(
                                onPressed: () {
                                  Authcontroller.showPassword();
                                },
                                icon: Icon(
                                  !Authcontroller.isShowpassword.value ? Icons.visibility_off:Icons.visibility,
                                  color: Tcolor.textTittle,
                                )),
                            controller: password,
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
                          );
                        }),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.04,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Tcolor.secoundarytext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  const TextSpan(
                                      text: 'By continuing you agree to our '),
                                  TextSpan(
                                      text: "Terms of Service",
                                      style: TextStyle(
                                          color: Tcolor.primary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                          color: Tcolor.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))
                                ])),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.05,
                        ),
                        Obx(() {
                          return RoundButton(
                            Title: Authcontroller.isloading.value == true
                                ? "Singing Up...."
                                : "Sign Up",
                            onpresed: () {
                              if (_formkey.currentState?.validate() ?? false) {
                                Authcontroller.serviceCallSignUp(
                                    emailcontrooler.text,
                                    namecontroller.text,
                                    password.text);
                              }
                            },
                            bgcolor: Authcontroller.isloading.value == true
                                ? Tcolor.disablecolor
                                : Tcolor.primary,
                          );
                        }),
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .width * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const Login());
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Already have an account?",
                                        style: TextStyle(
                                            color: Tcolor.primarytext,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text("Sign In ",
                                        style: TextStyle(
                                            color: Tcolor.primary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
