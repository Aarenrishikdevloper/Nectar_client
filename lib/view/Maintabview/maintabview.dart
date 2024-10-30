import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view/Cart/Cart.dart';
import 'package:nectar/view/Favorities/Favorites.dart';
import 'package:nectar/view/Home/home.dart';
import 'package:nectar/view/account/Account.dart';
import 'package:nectar/view/explore/Explore.dart';

class maintabview extends StatefulWidget {
  const maintabview({super.key});

  @override
  State<maintabview> createState() => _maintabviewState();
}

class _maintabviewState extends State<maintabview> with SingleTickerProviderStateMixin{
   TabController?controller;
   int selectedTab = 0;
   @override
  void initState() {

    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    controller = TabController(length: 5, vsync: this);
    controller?.addListener((){
      setState(() {
        selectedTab = controller!.index;
      });
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
controller: controller,
        children: [
          const Home(),
          const Explore(),
          const Cart(),
          const Favorites(),
          const Accounts(),
        ],


      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(15),
            topRight:Radius.circular(15),
          ),
          boxShadow: [
             BoxShadow(
               color:Colors.black26,
               blurRadius: 3,
               offset: Offset(0, -2)

             )
          ]
        ),
        child:BottomAppBar(
          color:Colors.transparent,
          elevation: 0,
          child:TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            indicatorWeight: 1,
            labelColor: Tcolor.primary,
            labelStyle: TextStyle(
              color:Tcolor.primarytext,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: Tcolor.primarytext,
            unselectedLabelStyle: TextStyle(
              color: Tcolor.primarytext,
              fontSize: 10,
              fontWeight: FontWeight.w600
            ),
            tabs: [
              Tab(
                text: "Shop",
                icon:Image.asset(
                  "assets/img/store_tab.png", width: 25, height: 25,
                  color: selectedTab == 0 ?Tcolor.primary : Tcolor.primarytext,
                )
              ),
              Tab(
                  text: "Search",
                  icon:Image.asset(
                    "assets/img/explore_tab.png", width: 25, height: 25,
                    color: selectedTab == 1 ?Tcolor.primary : Tcolor.primarytext,
                  )
              ),
              Tab(
                  text: "Cart",
                  icon:Image.asset(
                    "assets/img/cart_tab.png", width: 25, height: 25,
                      color: selectedTab == 2 ?Tcolor.primary : Tcolor.primarytext,


                  )
              ),
              Tab(
                  text: "Wishlist",
                  icon:Image.asset(
                    "assets/img/fav_tab.png", width: 25, height: 25,
                    color: selectedTab == 3 ?Tcolor.primary : Tcolor.primarytext,
                  )
              ),
              Tab(
                  text: "Account",
                  icon:Image.asset(
                    "assets/img/account_tab.png", width: 25, height: 25,
                    color: selectedTab == 4 ?Tcolor.primary : Tcolor.primarytext,
                  )
              ),

            ],
          )
        ) ,
      ),
    );
  }
}
