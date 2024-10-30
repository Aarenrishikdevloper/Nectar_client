import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/models/Promomodel.dart';

class Promocode_row extends StatelessWidget {
  final Promo pobj;
  final VoidCallback onTap;
  const Promocode_row({super.key, required this.pobj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          pobj.title,
                          style: TextStyle(
                              color: Tcolor.primarytext,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Tcolor.secoundarytext.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            pobj.promoCode,
                            style: TextStyle(
                                color: Tcolor.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      pobj.description,
                      style: TextStyle(
                          color: Tcolor.secoundarytext,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Expiry Date:",
                          style: TextStyle(
                              color: Tcolor.primarytext,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          utils.formatDate(pobj.endDate),
                          style: TextStyle(
                              color: Tcolor.secoundarytext,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
