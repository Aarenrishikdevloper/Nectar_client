import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Product_cell.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view_model/SearchController.dart';

import '../../view_model/addcartservice.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController txtsearch = TextEditingController();
  final controller = Get.put(Searchcontroller());

  @override
  void initState() {
    txtsearch.addListener(() {
      if (txtsearch.text.isEmpty) {
        controller.searchresult.value.clear(); // Only clear if text is empty
      }
      controller.searchquery(txtsearch.text);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtsearch.dispose();
    Get.delete<Searchcontroller>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Search product",
          style: TextStyle(
            color: Tcolor.primarytext,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                  child: Container(
                    height: 52,
                    width: 280.5,
                    decoration: BoxDecoration(
                      color: Color(0xffF2F3F2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: txtsearch,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Icon(
                                Icons.search,
                                color: Tcolor.secoundarytext,
                              )),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  txtsearch.text = "";
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Tcolor.secoundarytext,
                              )),
                          hintText: "Search Store",
                          hintStyle: TextStyle(
                            color: Tcolor.secoundarytext,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Obx(() {
              return Expanded(
                child: controller.isloading.value == false
                    ? GridView.builder(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.searchresult.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = controller.searchresult.value[index];
                          return productCell(
                            pobj: item,
                            onpressed: () {
                              CartService.serviceCallAddtocart(
                                  item!.id as String, 1, item!.price as double);
                            },
                            margin: 0,
                            width: double.maxFinite,
                          );
                        },
                      )
                    : SizedBox(),
              );
            })
          ],
        ),
      ),
    );
  }
}
