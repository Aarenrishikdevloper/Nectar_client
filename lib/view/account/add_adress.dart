import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/view/account/adress_screen.dart';

import '../../Comom_widget/dropdown.dart';
import '../../commons/constants.dart';
import '../../commons/themedata.dart';
import '../../view_model/adrees_create.dart';

class AddAdress extends StatefulWidget {

  const AddAdress({super.key});

  @override
  State<AddAdress> createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController namecontroiller = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController AddressLine = TextEditingController();
  final TextEditingController City = TextEditingController();
  final TextEditingController State = TextEditingController();
  final TextEditingController Postalcode = TextEditingController();
  final addressvm = Get.put(AdressCreateService());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    namecontroiller.dispose();
    mobile.dispose();
    AddressLine.dispose();
    City.dispose();
    State.dispose();
    Postalcode.dispose();
    Get.delete<AdressCreateService>();

  }

  var city;
  var state;
  @override




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
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
          centerTitle: true,
          title: Text(
            "Add Address",
            style: TextStyle(
                color: Tcolor.primarytext,
                fontSize: 20,
                fontWeight: FontWeight.w700
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
                    Row(
                      children: [
                        Obx(() {
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                addressvm.txtType.value = "Home";
                              },
                              child: Row(
                                children: [
                                  Icon(
                                      addressvm.txtType.value == "Home" ? Icons
                                          .radio_button_checked : Icons
                                          .radio_button_off,
                                      color: Tcolor.primarytext
                                  ),
                                  const SizedBox(width: 15,),
                                  Text("Home", style: TextStyle(
                                      color: Tcolor.primarytext,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                addressvm.txtType.value = "Office";
                              },
                              child: Row(
                                children: [
                                  Icon(
                                      addressvm.txtType.value == "Office"
                                          ? Icons
                                          .radio_button_checked
                                          : Icons
                                          .radio_button_off,
                                      color: Tcolor.primarytext
                                  ),
                                  const SizedBox(width: 15,),
                                  Text("Office", style: TextStyle(
                                      color: Tcolor.primarytext,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          );
                        }),


                      ],
                    ),
                    SizedBox(height: 15,),
                    lineInput(
                      title: "Name",
                      placeholder: "Enter Your name",
                      controller: namecontroiller,
                      validator: (value) {
                        if (value!.length < 3) {
                          return ("It is required");
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 15,),
                    lineInput(
                      title: "Mobile",
                      placeholder: "Enter Your Mobile no",
                      keyboardType: TextInputType.phone,
                      controller: mobile,
                      validator: (value) {
                        if (value!.length != 10) {
                          return ("It is required");
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 15,),
                    lineInput(
                      title: "Address Line",
                      placeholder: "Enter Your address",
                      controller: AddressLine,
                      validator: (value) {
                        if (value!.length < 3) {
                          return ("It is required");
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: Dropdown(title: 'City',
                              placeholder: "Select Your City",
                              selectValue: city,
                              valueList: constants().northeastIndiaCities,
                              didChange: (sobj) {
                                setState(() {
                                  city = sobj;
                                });
                              }),
                        ),
                        SizedBox(width: 9,),
                        Expanded(
                          child: Dropdown(title: "State",
                              placeholder: "Select Your State",
                              selectValue: state,
                              valueList: constants()
                                  .northeastIndiaStatesWithoutSikkim,
                              didChange: (sobj) {
                                setState(() {
                                  state = sobj;
                                });
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    lineInput(
                      title: "Postal Code",
                      placeholder: "Enter Your Postal Code",
                      controller:Postalcode,
                      validator: (value) {
                        if (value!.length < 3) {
                          return ("It is required");
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 25,),
                    Obx(() {
                      return RoundButton(Title: addressvm.isloading.value  == false?  "Add Address":"Saving...", onpresed: () {
                        if (_formkey.currentState?.validate() ?? false) {
                          if (city != null && state != null) {
                            addressvm.serviceCreateAdress(
                                namecontroiller.text,
                                mobile.text,
                                AddressLine.text,
                                city,
                                state,
                                Postalcode.text,
                                addressvm.txtType.toString());
                          }
                        }


                      },bgcolor:addressvm.isloading.value == false ?Tcolor.primary:Tcolor.disablecolor,);
                    })

                  ],
                ),

              ),
            )
        )
    );
  }
}
