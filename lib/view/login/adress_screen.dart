import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/dropdown.dart';
import 'package:nectar/Comom_widget/lineInput.dart';
import 'package:nectar/commons/constants.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view_model/adrees_create.dart';

class adressCreation extends StatefulWidget {
  const adressCreation({super.key});

  @override
  State<adressCreation> createState() => _adressCreationState();
}

class _adressCreationState extends State<adressCreation> {


  @override



  final AdressCreateService AdressController = Get.put(AdressCreateService());
  var city;
  var state;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset("assets/img/bottom_bg.png",
              width: MediaQuery.sizeOf(context).height, fit: BoxFit.cover),
        ),
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/select_location.png",
                        width: MediaQuery.sizeOf(context).width * 0.6,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width * 0.1,
                      ),
                      Text(
                        "Select Your Location",
                        style: TextStyle(
                            color: Tcolor.primarytext,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                      Text(
                        "Switch on Your Location to stay in tune with\nwhat's happening in your area",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Tcolor.secoundarytext,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width * 0.1,
                      ),
                      Dropdown(title: 'City', placeholder:"Select Your City",selectValue:city, valueList:constants().northeastIndiaCities, didChange:(sobj){
                        setState(() {
                          city = sobj;
                        });

                      }),
                      SizedBox(height:MediaQuery.sizeOf(context).width*0.07
                        ,),
                      Dropdown(title: 'State', placeholder:"Select Your State",selectValue:state, valueList:constants().northeastIndiaStatesWithoutSikkim, didChange:(sobj){
                        setState(() {
                          state = sobj;
                        });

                      }),

                      Obx(() {
                        return RoundButton(
                          Title: AdressController.isloading.value == true
                              ? "Saving...."
                              : "Save",
                          onpresed: () {
                             if(city == null && state == null){
                               return;
                             }
                             AdressController.servicelocation(city, state);
                          },
                          bgcolor: AdressController.isloading.value == true
                              ? Tcolor.disablecolor
                              : Tcolor.primary,
                        );
                      }),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width * 0.1,
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
