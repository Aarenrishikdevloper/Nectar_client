import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nectar/Comom_widget/Buttons.dart';
import 'package:nectar/commons/themedata.dart';
import 'package:nectar/commons/utils.dart';
import 'package:nectar/view_model/HomeService.dart';
import 'package:nectar/view_model/addcartservice.dart';
import 'package:nectar/view_model/productDetailService.dart';

class ProductDetailview extends StatefulWidget {
  final String ProductId;

  const ProductDetailview({super.key, required this.ProductId});

  @override
  State<ProductDetailview> createState() => _ProductDetailviewState();
}

class _ProductDetailviewState extends State<ProductDetailview> {
  final productservice = Get.put(Productdetailservice());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   productservice.fetchdetails(widget.ProductId);

  }


  bool show = false;

  void showdescription() {
    setState(() {
      show = !show;
    });
  }

  bool shownutri = false;

  void shownutrition() {
    setState(() {
      shownutri = !shownutri;
    });
  }

  String getPrice() {
    var pricefinal = (productservice.Productdetails.value?.price)! *
        productservice.qty.value;
    return utils.formatPrice(pricefinal);
  }

  void tap() {
    print(productservice.qty);
    var price = getPrice();
    var priceWithoutRupee = price.replaceAll(RegExp(r'₹'), '');

    var actualprice = double.parse(priceWithoutRupee);
    if (productservice.Productdetails.value?.id.toString() ==
        productservice.Productdetails.value?.cartid.toString()) {
      CartService.serviceCallEditCart(
          productservice.Productdetails.value?.id as String,
          productservice.qty.value.toInt(),
          actualprice);
    } else {
      CartService.serviceCallAddtocart(
          productservice.Productdetails.value?.id as String,
          productservice.qty.value.toInt(),
          actualprice);
    }
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return

      Obx(() {
        return   productservice.isloading.value == false ? Scaffold(
            backgroundColor: Colors.white,
            body:

            SingleChildScrollView(
                child:
               Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.topCenter, children: [
                      Container(
                          width: double.maxFinite,
                          height: media.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: productservice
                              .Productdetails.value!.image!.isNotEmpty
                              ? SafeArea(
                                child: Column(
                                                            children: [
                                Expanded(
                                  child: CarouselSlider(
                                    items: productservice
                                        .Productdetails.value?.image
                                        .map(
                                          (image) =>
                                          CachedNetworkImage(
                                            imageUrl: image,
                                            width: media.width * 0.8,
                                          ),
                                    )
                                        .toList(),
                                    options: CarouselOptions(
                                        height: media.width * 0.8,
                                        viewportFraction: 1.0,
                                        enableInfiniteScroll: false,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _currentIndex = index;
                                          });
                                        }),
                                  ),
                                ),
                                if (productservice.Productdetails.value!
                                    .image.length >
                                    1)
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: productservice
                                        .Productdetails.value!
                                        .image
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                
                                        child: Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _currentIndex ==
                                                  entry.key
                                                  ? Tcolor.primary
                                                  : Colors.grey
                                                  .withOpacity(0.7),
                                            )),
                                      );
                                    }).toList(),
                                  )
                                                            ],
                                                          ),
                              )
                              : SizedBox()),
                      SafeArea(
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image.asset(
                              "assets/img/back.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          actions: [
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "assets/img/share.png",
                                  width: 20,
                                  height: 20,
                                ))
                          ],
                        ),
                      )
                    ]),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  productservice.Productdetails.value
                                      ?.name as String,
                                  style: TextStyle(
                                      color: Tcolor.primarytext,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Obx(() {
                                return IconButton(
                                    onPressed: () {
                                      productservice.toggleFav(productservice
                                          .Productdetails.value?.id as String);
                                    },
                                    icon: Image.asset(
                                      productservice.status.value == true
                                          ? "assets/img/favorite.png"
                                          : "assets/img/fav.png",
                                      width: 25,
                                      height: 25,
                                    ));
                              })
                            ],
                          ),
                          Text(
                            " ${productservice.Productdetails.value
                                ?.unitvalue}  ${productservice.Productdetails
                                .value
                                ?.unitname}, Price ",
                            style: TextStyle(
                                color: Tcolor.primarytext,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  productservice.addsubqty(isAdd: false);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Image.asset(
                                    "assets/img/subtack.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Tcolor.placeholder
                                            .withOpacity(0.5),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.center,
                                child: Obx(() {
                                  return Text(
                                    productservice.qty.toString(),
                                    style: TextStyle(
                                        color: Tcolor.primarytext,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  );
                                }),
                              ),
                              InkWell(
                                onTap: () {
                                  productservice.addsubqty(isAdd: true);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Image.asset(
                                    "assets/img/add_green.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                getPrice(),
                                style: TextStyle(
                                    color: Tcolor.primarytext,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Product Details",
                                  style: TextStyle(
                                      color: Tcolor.primarytext,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showdescription();
                                  },
                                  icon: Image.asset(
                                    show == true
                                        ? "assets/img/detail_open.png"
                                        : "assets/img/next.png",
                                    width: 15,
                                    height: 15,
                                    color: Tcolor.primarytext,
                                  ))
                            ],
                          ),
                          show == true
                              ? Text(
                            productservice
                                .Productdetails.value!.details,
                            style: TextStyle(
                                color: Tcolor.secoundarytext,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          )
                              : Container(),
                          SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Nutrition",
                                  style: TextStyle(
                                      color: Tcolor.primarytext,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Tcolor.placeholder.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${productservice.Productdetails.value
                                      ?.nutritionweight} " ?? "100gm",
                                  style: TextStyle(
                                    color: Tcolor.secoundarytext,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),

                                ),
                              ),
                              IconButton(
                                  onPressed: shownutrition,
                                  icon: Image.asset(
                                    shownutri == true
                                        ? "assets/img/detail_open.png"
                                        : "assets/img/next.png",
                                    width: 15,
                                    height: 15,
                                    color: Tcolor.primarytext,
                                  ))
                            ],
                          ),
                          if(shownutri == true ) ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var nobj = productservice.Productdetails.value
                                  ?.nutritionlist?[index];
                              return Row(

                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [

                                  Text(
                                    nobj?.nutrionName as String,
                                    style: TextStyle(
                                        color: Tcolor.secoundarytext,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    ),

                                  ),
                                  Text(
                                    nobj?.nutritionValue as String,
                                    style: TextStyle(
                                        color: Tcolor.primarytext,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    ),

                                  )
                                ],
                              );
                            },
                            itemCount: productservice.Productdetails.value
                            !.nutritionlist!.length,
                            separatorBuilder: (context, builder) =>
                                Divider(
                                    color: Colors.black12
                                ),

                          ),
                          SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Reviews",
                                  style: TextStyle(
                                      color: Tcolor.primarytext,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              IgnorePointer(
                                ignoring: true,
                                child: RatingBar.builder(
                                  initialRating: double.tryParse(
                                      productservice.Productdetails.value
                                          ?.averageRating as String) as double,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 15,
                                  itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1),
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  onRatingUpdate: (value) {
                                    print(value);
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/img/next.png",
                                    width: 15,
                                    height: 15,
                                    color: Tcolor.primarytext,
                                  ))
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          SizedBox(height:20,),
                          Padding(
                            padding: EdgeInsets.only(bottom:MediaQuery.of(context).padding.bottom),
                              child:RoundButton(
                                Title: "Add To Basket",
                                onpresed: tap,
                                height: 70,
                              ),

                          ),
                        ],
                      ),
                    ),

                  ],
                )


            )


        ):SizedBox();
      });
  }
}
