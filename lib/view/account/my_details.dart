import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:nectar/models/usermodel.dart';
import 'package:nectar/view/account/ChangePassword.dart';
import 'package:nectar/view_model/UserService.dart';

import '../../view_model/auth.dart';

class MyDetails extends StatefulWidget {
  final UserModel? user;

  const MyDetails({super.key, required this.user});

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  final _formkey = GlobalKey<FormState>();


  late TextEditingController namecontroller = TextEditingController(
      text: widget.user!.name);
  late TextEditingController emailcontroller = TextEditingController(
      text: widget.user!.email);
  late TextEditingController controller = TextEditingController(
      text: widget.user!.mobileNumber);
  late String codemobile =widget.user!.countryCode  == null ?"IN":widget.user!.countryCode as String;
  FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  late CountryCode countrycode;
  final service = Get.put(Userservice());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countrycode =
        countryPicker.countryCodes.firstWhere((element) => element.code ==
            codemobile, orElse: () => countryPicker.countryCodes.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
        "My Details",
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
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  lineInput(
                    title: "Username",
                    placeholder: "Enter Your name",
                    controller: namecontroller,
                    validator: (value) {
                      if (value!.length < 3) {
                        return ("It is required");
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  lineInput(
                    title: "Email",
                    placeholder: "Enter Your Email",
                    controller: emailcontroller,
                    validator: (value) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile Number",
                        style: TextStyle(
                            color: Tcolor.textTittle,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      TextField(
                        controller: controller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: GestureDetector(
                              onTap: () async {
                                var code = await countryPicker.showPicker(
                                    context: context);
                                if (code != null) {
                                  setState(() {
                                    countrycode = code;
                                    codemobile = code.code;
                                  });
                                }
                                print(codemobile);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    width: 35,
                                    height: 35,
                                    child: countrycode.flagImage(),
                                  ),
                                  Text(
                                    countrycode.dialCode,
                                    style: TextStyle(
                                        color: Tcolor.primarytext,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),

                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: " Mobile Number ",
                            hintStyle: TextStyle(
                                fontSize: 17,
                                color: Tcolor.primarytext
                            )

                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        color: Color(0xffE2E2E2),
                      )
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Obx(() {
                    return RoundButton(
                      Title:service.isloading.value ==false? "Update":"Updating....",
                      onpresed: () {
                        if (_formkey.currentState?.validate() ?? false) {
                          service.UserUpdate(
                              namecontroller.text, emailcontroller.text,
                              codemobile , controller.text);
                        }
                      },
                      bgcolor:service.isloading.value == true?Tcolor.disablecolor:Tcolor.primary ,

                    );
                  }),
                  SizedBox(height: 40,),
                  TextButton(
                    onPressed: () {
                      Get.to(()=>const Changepassword());
                    },
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                          color: Tcolor.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ));
  }
}
