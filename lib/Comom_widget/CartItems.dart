import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/cartmodel.dart';

class Cartitems extends StatelessWidget {
  final CartModel cobj;
  final VoidCallback onDelete;
  final VoidCallback onIncqty;
  final VoidCallback ondeccqty;

  const Cartitems(
      {super.key, required this.cobj,  required this.onDelete, required this.onIncqty, required this.ondeccqty});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 120,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(imageUrl: cobj.image,
                  width: 80,
                  height: 65,
                  fit: BoxFit.contain,),
                const SizedBox(height: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(cobj.name, style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                          ),
                          InkWell(
                            onTap: onDelete,
                            child: Image.asset('assets/img/close.png',
                              width: 15,
                              height: 15,
                              color: Tcolor.secoundarytext,),
                          )
                        ],
                      ),
                      const SizedBox(height: 2,),
                      Text(
                          "${cobj.unitValue} ${cobj.unitName}  price",
                          style: TextStyle(color: Tcolor.secoundarytext,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          InkWell(
                            onTap: ondeccqty,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Tcolor.placeholder.withOpacity(0.5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/img/subtack.png", width: 15,
                                height: 15,),
                            ),
                          ),
                          const SizedBox(width: 15,),

                             Text(
                               cobj.qty.toString(),
                              style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          const SizedBox(width: 15,),
                          InkWell(
                            onTap: onIncqty,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Tcolor.placeholder.withOpacity(0.5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/img/add_green.png", width: 15,
                                height: 15,),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            utils.formatPrice(cobj.price),
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      )
                    ],
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
