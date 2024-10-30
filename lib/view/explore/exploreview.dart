import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Product_cell.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/models/Product.dart';
import 'package:nectar/view_model/SearchController.dart';

import '../../view_model/addcartservice.dart';

class Exploreview extends StatefulWidget {
  final String cat;

  const Exploreview({super.key, required this.cat});

  @override
  State<Exploreview> createState() => _ExploreviewState();
}

class _ExploreviewState extends State<Exploreview> {
  final controller = Get.put(Searchcontroller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getcat(widget.cat);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_list,
                color: Tcolor.primarytext,
              ),
            ),
          ],
          title: Text(
            widget.cat,
            style: TextStyle(
              color: Tcolor.primarytext,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body:controller.isloading.value == false? GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.76,
              crossAxisSpacing:15,
              mainAxisSpacing: 15),
          itemCount: controller.catproduct.value.length,
          itemBuilder: (BuildContext context, int index) {
            var item = controller.catproduct.value[index];
            return productCell(
              pobj: item,
              onpressed: () {
                CartService.serviceCallAddtocart(item!.id as String, 1, item!.price as double);
              },
              margin: 0,
              width: double.maxFinite,
            );
          },
        ):SizedBox(),
      );
    });
  }
}
