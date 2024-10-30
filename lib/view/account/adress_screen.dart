import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/adressrow.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/models/Adressmodel.dart';
import 'package:nectar/view/account/add_adress.dart';
import 'package:nectar/view/account/edit_adress.dart';
import 'package:nectar/view_model/fetchAdress.dart';

import '../../view_model/adrees_create.dart';

class AdressScreen extends StatefulWidget {
  final Function(AddressModel aobj)? didselect;
  const AdressScreen({super.key, this.didselect});

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  final addressvm = Get.put(fetchAdress());

  @override
  void initState() {
    addressvm.fetchadress();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<fetchAdress>();
  }

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
            "Delivery Address",
            style: TextStyle(
                color: Tcolor.primarytext,
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                addressvm.clearAll();
                await Get.to(() => const AddAdress());
              },
              icon: Image.asset("assets/img/add.png", width: 20,
                height: 20,
                color: Tcolor.primarytext,),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body:
        Obx(() {
          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              separatorBuilder: (context, index) =>
              const Divider(color: Colors.black26, height: 1,),
              itemCount: addressvm.adddress.value.length,
              itemBuilder: (BuildContext context, int index) {
                var item = addressvm.adddress.value[index];
                return Adddresrow(aobj: item, onDelete: () {
                  addressvm.deleteasress(item.id);
                }, onedit: () async{
                   addressvm.clearAll();
                   await Get.to(()=>EditAdress(aobj:item));
                },
                 ontap:(){
                  if(widget.didselect != null){
                    widget.didselect!(item);
                    Navigator.pop(context);
                  }
                 },

                );
              });
        })


    );
  }
}
