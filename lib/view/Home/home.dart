import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Categorytype.dart';
import 'package:nectar/Comom_widget/OfferProduct_cell.dart';
import 'package:nectar/Comom_widget/Product_cell.dart';
import 'package:nectar/Comom_widget/Section.dart';
import 'package:nectar/Comom_widget/image_carousel.dart';
import 'package:nectar/commons/constants.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/Product.dart';
import 'package:nectar/view/Home/Product_detailview.dart';
import 'package:nectar/view/explore/Explore.dart';
import 'package:nectar/view_model/HomeService.dart';
import 'package:nectar/view_model/addcartservice.dart';

import '../explore/Search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homevm = Get.put(Homeservice());

  @override
  void dispose() {
    Get.delete<Homeservice>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: homevm.isloading.value == false
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/color_logo.png",
                            width: 25,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/location.png",
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx(() {
                            return Text(
                              '${homevm.address.value.city}, ${homevm.address.value.state}',
                              style: TextStyle(
                                color: Tcolor.darkgrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          })
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Search())),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xffF2f3F2),
                                borderRadius: BorderRadius.circular(15)),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(13),
                                  child: Icon(Icons.search,
                                      color: Tcolor.secoundarytext),
                                ),
                                Text(
                                  "Search Store",
                                  style: TextStyle(
                                      color: Tcolor.secoundarytext,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ImageWidget(),
                      ),
                      homevm.offers.length != 0
                          ? const section(
                              title: "Exclusive Offer",
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                            )
                          : SizedBox(),
                      homevm.offers.length != 0
                          ? SizedBox(
                              height: 230,
                              child: Obx(() {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  itemCount: homevm.offers.length,
                                  itemBuilder:
                                      (BuildContext contex, int index) {
                                    var items = homevm.offers[index];
                                    return offerProductCell(
                                      pobj: items,
                                      onpressed: () {
                                        Get.to(() => ProductDetailview(
                                            ProductId: items.productId));
                                      },
                                      onClick: () {
                                        CartService.serviceCallAddtocart(
                                            items.productId, 1, items.price);
                                      },
                                    );
                                  },
                                );
                              }),
                            )
                          : SizedBox(),
                      const section(
                        title: "Best Selling",
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                      SizedBox(
                        height: 230,
                        child: Obx(() {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            itemCount: homevm.latestProduct.length,
                            itemBuilder: (BuildContext contex, int index) {
                              var items = homevm.latestProduct[index];
                              return productCell(
                                pobj: items,
                                onpressed: () {
                                  CartService.serviceCallAddtocart(
                                      items!.id as String,
                                      1,
                                      items.price as double);
                                },
                              );
                            },
                          );
                        }),
                      ),
                      const section(
                        title: "Groceries",
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            itemCount: 5,
                            itemBuilder: (BuildContext contex, int index) {
                              var items = constants.groceryCategories[index];
                              Color random = utils.getRandomColor();
                              return categorycart(
                                category: items,
                                color: random,
                              );
                            }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          height: 230,
                          child: Obx(() {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              itemCount: homevm.otherproducts.length,
                              itemBuilder: (BuildContext contex, int index) {
                                var items = homevm.otherproducts[index];
                                return productCell(
                                  pobj: items,
                                  onpressed: () {
                                    CartService.serviceCallAddtocart(
                                        items!.id as String,
                                        1,
                                        items.price as double);
                                  },
                                );
                              },
                            );
                          })),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            : null,
      );
    });
  }
}
