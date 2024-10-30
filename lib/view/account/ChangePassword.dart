import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/view_model/UserService.dart';

import '../../commons/themedata.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController currentpassword = TextEditingController();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final service = Get.put(Userservice());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          "Change Password",
          style: TextStyle(
              color: Tcolor.primarytext,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/img/back.png',
            width: 20,
            height: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Column(
                  children: [
                    lineInput(
                      title: "Current password",
                      placeholder: "Enter your current Password",
                      obsecuretext: true,
                      controller: currentpassword,
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
                    const SizedBox(height: 15,),
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
                    const SizedBox(height: 15,),
                    lineInput(
                      title: "Confirm password",
                      placeholder: "Conirm Your Password",
                      obsecuretext: true,
                      controller:confirmpassword,
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
                    const SizedBox(height: 15,),

                  ],
                ),
                const SizedBox(height: 25,),
                Obx(() {
                  return RoundButton(Title:service.isloading.value == false? "Set":'loading...', onpresed: () async {
                    var result = await service.changepassword(newpassword.text);
                    if (result) {
                      Navigator.pop(context);
                    }
                  },
                  bgcolor:service.isloading.value == false?Tcolor.primary:Tcolor.disablecolor,);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
