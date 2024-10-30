
import 'package:flutter/material.dart';
import 'package:nectar/Comom_widget/explore_cell.dart';
import 'package:nectar/commons/constants.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/view/explore/Search.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0,
         centerTitle: true,
         title: Text("Explore Product", style:TextStyle(
           color: Tcolor.primarytext,
           fontSize:20,
           fontWeight: FontWeight.w700,
         ),),




       ),
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: InkWell(
                onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(context)=> const Search())),
                child: Container(
                  height:45,
                  decoration: BoxDecoration(
                    color:Color(0xffF2f3F2),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(13),
                        child: Icon(Icons.search, color:Tcolor.secoundarytext),

                      ),
                      Text("Search Store", style:TextStyle(color:Tcolor.secoundarytext, fontSize:14, fontWeight: FontWeight.w600 ),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height:15,),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical:15, horizontal:20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
              
                ),
                itemCount: constants.groceryCategories.length,
                itemBuilder: (BuildContext context, int index){
                  var items = constants.groceryCategories[index];
                  Color randomcolor = utils.getRandomColor();
                  return ExploreCell(
                    pobj: items,
                    color: randomcolor,
                  );
                },
              ),
            ),


          ],
        ),
      )
      
    );
  }
}
