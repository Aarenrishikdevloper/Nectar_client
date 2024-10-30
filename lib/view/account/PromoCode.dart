import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/promocode.dart';
import 'package:nectar/models/Promomodel.dart';
import 'package:nectar/view_model/fetchpromo.dart';

import '../../commons/themedata.dart';

class Promocode extends StatefulWidget {
  final Function(Promo pobj)?didSelect;
  const Promocode({super.key, this.didSelect});

  @override
  State<Promocode> createState() => _PromocodeState();
}

class _PromocodeState extends State<Promocode> {
  final service = Get.put(fetchpromo());

  @override
  void initState() {
    service.fetchpromocode();
    // TODO: implement initState
    super.initState();
  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    service.promo.value.clear();
    Get.delete<fetchpromo>();
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
                "assets/img/back.png",
                width: 20,
                height: 20,
              )


          ),
          centerTitle: true,
          title: Text(
            "Promo Code",
            style: TextStyle(
                color: Tcolor.primarytext,
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),

        ),
        backgroundColor: Colors.white,
        body: Obx(() {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            itemBuilder: (BuildContext context, int index) {
              var pobj = service.promo.value[index];
              return(
              Promocode_row(pobj: pobj, onTap:(){
                if(widget.didSelect != null){
                  widget.didSelect!(pobj);
                  Navigator.pop(context);
                }
              },)
              );

            },
            itemCount:service.promo.value.length,
            separatorBuilder:(context, index)=> const Divider(color:Colors.black12, height: 1,)

          );
        })
    );
  }
}
