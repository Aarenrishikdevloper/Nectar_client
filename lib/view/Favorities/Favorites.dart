import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/Comom_widget/Fav_row.dart';
import 'package:nectar/view_model/favoriteservice.dart';

import '../../commons/themedata.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();


}


class _FavoritesState extends State<Favorites> {
  final favvm = Get.put(FavService());

  void dispose() {
    Get.delete<FavService>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text("Favorites", style: TextStyle(color: Tcolor.primarytext,
              fontSize: 20,
              fontWeight: FontWeight.w700),),
          centerTitle: true,

        ),
        body: favvm.isloading.value == false ? Obx(() {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              favvm.favProduct.value.isEmpty ? Center(child: Text(
                  "No Items In favorites", style: TextStyle(
                  color: Tcolor.primarytext,
                  fontWeight: FontWeight.w700,
                  fontSize: 20)),) : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                scrollDirection: Axis.vertical,
                itemCount: favvm.favProduct.value.length,
                separatorBuilder: (context, builder) =>
                const Divider(color: Colors.black26, height: 1,),

                itemBuilder: (BuildContext context, int index) {
                  var item = favvm.favProduct.value[index];
                  return FavRow(pobj: item);
                },
              ),
              favvm.favProduct.value.isNotEmpty ? Padding(
                padding: EdgeInsets.all(20),
                child: Obx(() {
                  return RoundButton(
                    Title:favvm.isloading.value == false? "Add All to Card":"...Adding",
                    onpresed: () {
                      favvm.AddAlltocart(favvm.favProduct.value.map((item) =>
                      ({
                        'id': item.ProductId,
                        'price': item.price
                      })).toList(),);
                    },
                    bgcolor:favvm.isloading.value == false?Tcolor.primary:Tcolor.disablecolor ,
                  );
                }),
              ) : SizedBox()
            ],
          );
        }) : null,
      );
    });
  }
}
