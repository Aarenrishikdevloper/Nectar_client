import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/view_model/OrderDetailview.dart';
import 'package:nectar/view_model/reviewservice.dart';

class WriteReview extends StatefulWidget {
  final prodId;

  const WriteReview({super.key, required this.prodId});

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final service = Get.put(Reviewservice());
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      height: context.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 10
                  )
                ]
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40,),
                    Text(
                      "Write A Review",
                      style: TextStyle(
                          color: Tcolor.primarytext,
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                      ),


                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                        color: Tcolor.primary,
                      ),

                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: RatingBar.builder(
                    initialRating: service.rating.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: context.width * 0.12,
                    itemPadding: EdgeInsets.symmetric(vertical: 15),
                    itemBuilder: (context, _) =>
                        Icon(
                          Icons.star,
                          color: Colors.amber,

                        ),
                    onRatingUpdate: (double value) {
                      service.rating.value = value;
                      print(service.rating.value);
                    },


                  ),
                ),
                TextField(
                  maxLines: 10,
                  minLines: 10,
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintText: "write a review",
                      filled: true
                  ),
                  style: TextStyle(color: Tcolor.primary),
                ),
                const SizedBox(height: 10,),
                Obx(() {
                  return RoundButton(Title:service.isloading.value == false? "Submit":"Submitting...", onpresed: () async {
                    final msg = await service.review(widget.prodId, controller
                        .text);
                    if (msg == true) {
                      Navigator.pop(context);
                    } else {
                      Get.snackbar("Error", "Something Went Wrong");
                    }

                  },bgcolor: service.isloading.value == true
                  ? Tcolor.disablecolor
                    : Tcolor.primary,
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
