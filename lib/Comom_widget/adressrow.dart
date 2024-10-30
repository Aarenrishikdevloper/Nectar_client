import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/commons/themedata.dart';

import '../models/Adressmodel.dart';

class Adddresrow extends StatelessWidget {
  final  AddressModel aobj;
  final VoidCallback onDelete;
  final VoidCallback onedit;
  final VoidCallback ontap;
  const Adddresrow({super.key, required this.aobj, required this.onDelete, required this.onedit, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:ontap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical:8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color:Colors.black12, blurRadius:2)]
        ),
        padding:EdgeInsets.symmetric(vertical:15) ,
        child:Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left:15),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child:Text(
                            aobj.name,
                            style: TextStyle(
                              color:Tcolor.primarytext,
                              fontSize:14,
                              fontWeight:FontWeight.w700
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal:5,vertical:2),
                          decoration: BoxDecoration(
                            color: Tcolor.secoundarytext.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Text(aobj.type, style:TextStyle(
                              color:Tcolor.secoundarytext,
                              fontSize:12,
                              fontWeight:FontWeight.w700
                          ),),
                        ), 

                      ],
                    ),
                    SizedBox(height:4,),
                    Text("${aobj.addressLine} ${aobj.city} ${aobj.state} ${aobj.postalCode}", textAlign:TextAlign.left,  style: TextStyle(
                        color:Tcolor.primarytext,
                        fontSize:14,
                        fontWeight:FontWeight.w500
                    ), ),
                    SizedBox(height:8,),
                    Text("${aobj.mobileNumber} ", textAlign:TextAlign.left,  style: TextStyle(
                        color:Tcolor.secoundarytext,
                        fontSize:12,
                        fontWeight:FontWeight.w500
                    ), ),

                  ],
                ),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap:onedit,
                  child: Icon(Icons.edit, color:Tcolor.primary,size:20,),
                ),
                IconButton(
                  onPressed:onDelete,
                  icon: Icon(Icons.close, size:15,),
                ),

              ],
            )
          ],
        ) ,
      ),
    );
  }
}
