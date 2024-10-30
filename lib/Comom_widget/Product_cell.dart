import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/Product.dart';
import 'package:nectar/view/Home/Product_detailview.dart';



class productCell extends StatelessWidget {
  final Product pobj;
  final double margin;
  final double width;
  final VoidCallback onpressed;

  const productCell(
      {super.key, required this.pobj, this.margin = 8, this.width = 180, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailview(ProductId: pobj!.id as String));
      },
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: margin),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border.all(color: Tcolor.placeholder.withOpacity(0.5), width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: pobj.image![0] as String,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: 100,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const Spacer(),
            Text(
              pobj!.name as String,
              style: TextStyle(
                fontSize: 16,
                color: Tcolor.primarytext,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              " ${pobj!.unitValue} ${pobj!.unitName}  Price ",
              style: TextStyle(
                fontSize: 14,
                color: Tcolor.secoundarytext,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  utils.formatPrice(pobj!.price as double),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Tcolor.primary),
                ),
                InkWell(
                    onTap:onpressed,

                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Tcolor.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/img/add.png",
                        width: 15,
                        height: 15,
                      ),
                    ),
                    )

              ],
            )
          ],
        ),
      ),
    );
  }
}
