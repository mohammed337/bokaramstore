import 'package:bokaramstore/SCR/shoppingCart.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_products_details_json.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'login.dart';

class ProductDetails extends StatefulWidget {
  String product_id;
  String product_name;

  ProductDetails(this.product_id, {this.product_name});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String token;
  List<Widget> itemSliders3 = [];

  @override
  void initState() {
    token = box.read('token');
  }
  int currentIndex;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int _current = 0;
    print(widget.product_id);
    double _rating = 0;
    double rat = 0;
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('مرحبا بك'),
        ),
        body:
        StreamBuilder<Get_products_details_json>(
            stream: _allNetworking
                .get_products_details(
                    product_id: widget.product_id, lang: 'ar', token_id: token)
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data.result.allSlider.length; i++) {
                  currentIndex= snapshot.data.result.allSlider.length;
                  itemSliders3.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: size.width * .8,
                      height: size.height * .3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          snapshot.data.result.allSlider[i].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ));
                }
                if (!snapshot.data.result.productsDetails[0].totalRate
                    .trim()
                    .isEmpty) {
                  rat = double.parse(
                      snapshot.data.result.productsDetails[0].totalRate);
                } else {
                  rat = 0;
                }
                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId:
                      snapshot.data.result.productsDetails[0].videoLink,
                  flags: YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                  ),
                );
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        snapshot.data.result.productsDetails[0].displayType == 0
                            ? Container(
                                child: Column(
                                  children: [
                                    CarouselSlider(
                                      items: itemSliders3,
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        },
                                        viewportFraction: .9,
                                        aspectRatio: 2.0,
                                        enlargeCenterPage: true,
                                      ),
                                    ),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: itemSliders3.map((url) {
                                    //     int index = itemSliders3.indexOf(url);
                                    //     return Container(
                                    //       width: 8.0,
                                    //       height: 8.0,
                                    //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    //       decoration: BoxDecoration(
                                    //         shape: BoxShape.circle,
                                    //         color: _current == index
                                    //             ? Color.fromRGBO(0, 0, 0, 0.9)
                                    //             : Color.fromRGBO(0, 0, 0, 0.4),
                                    //       ),
                                    //     );
                                    //   }).toList(),
                                    // ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(20),
                                // height: MediaQuery.of(context).size.height * .3,
                                // width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: YoutubePlayer(
                                    controller: _controller,
                                    showVideoProgressIndicator: true,
                                  ),
                                )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < snapshot.data.result.allSlider.length; i++)
                                Container(
                                    height: 10, width: 10,
                                   decoration: BoxDecoration(
                                        color: i == currentIndex ? Colors.white : Colors.grey,
                                        borderRadius: BorderRadius.circular(5)
                                    )
                                )
                            ]
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.product_name,
                                //  textAlign: TextAlign.,
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black87),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RatingBar(
                                  onRatingChanged: (rating) {
                                    _rating = rating;
                                    print(snapshot
                                        .data.result.productsDetails[0].id);
                                    _allNetworking
                                        .add_review(
                                            product_id: snapshot.data.result
                                                .productsDetails[0].id,
                                            rating: rating.toInt(),
                                            token_id: token,
                                            lang: 'ar')
                                        .then((value) {
                                      Get.snackbar('', value.message);
                                      setState(() {});
                                    });
                                  },
                                  filledIcon: Icons.star,
                                  initialRating: rat,
                                  emptyIcon: Icons.star_border,
                                  halfFilledIcon: Icons.star_half,
                                  isHalfAllowed: true,
                                  filledColor: Colors.green,
                                  emptyColor: Colors.redAccent,
                                  halfFilledColor: Colors.amberAccent,
                                  size: 20,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final link = WhatsAppUnilink(
                                    phoneNumber: snapshot.data.result
                                        .productsDetails[0].whatsapp,
                                    text: snapshot
                                        .data.result.productsDetails[0].share,
                                  );
                                  // Convert the WhatsAppUnilink instance to a string.
                                  // Use either Dart's string interpolation or the toString() method.
                                  // The "launch" method is part of "url_launcher".
                                  await launch('$link');
                                },
                                child: Container(
                                    height: 50,
                                    width: 75,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular((10))),
                                      child: Center(
                                        child: Text(
                                          snapshot
                                                  .data
                                                  .result
                                                  .productsDetails[0]
                                                  .discountPercentage +
                                              '%',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot.data.result.productsDetails[0]
                                      .newPrice+' '+
                                  snapshot.data.result.productsDetails[0]
                                          .currencyName
                                     ,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(

                                      fontSize: 18, color: Colors.black54,),
                                ),
                                Text(" / "),
                                Stack(
                                  children: [
                                    Positioned(
                                      top: 12,
                                      child: Container(
                                        height: 2,
                                        width: 80,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data.result.productsDetails[0]
                                              .oldPrice +
                                          ' ' +
                                          snapshot.data.result
                                              .productsDetails[0].currencyName,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final link = WhatsAppUnilink(
                                        phoneNumber: snapshot.data.result
                                            .productsDetails[0].whatsapp,
                                        text: 'طلب منتج ${snapshot.data.result.productsDetails[0].productDetails} ' +
                                            'بسعر ${snapshot.data.result.productsDetails[0].newPrice} ',
                                      );
                                      // Convert the WhatsAppUnilink instance to a string.
                                      // Use either Dart's string interpolation or the toString() method.
                                      // The "launch" method is part of "url_launcher".
                                      await launch('$link');
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset(
                                          'assets/images/what.png',
                                          // color: Colors.blue[800],
                                        )),
                                  ),
                                ),
                                Text("تواصل واتس اب"),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('الوصف',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.result.productsDetails[0]
                                    .productDetails,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.grey,
                                  wordSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Center(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 50,height: 50,
                                          decoration: BoxDecoration( color: Colors.grey,
                                              borderRadius:BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              '-',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 50,height: 50,
                                          decoration: BoxDecoration( color: Colors.blue[600],
                                              borderRadius:BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              '1',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 50,height: 50,
                                          decoration: BoxDecoration( color: Colors.grey,
                                              borderRadius:BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              '+',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height*.17,),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (token == null) {
                              Get.to(LoginSCR());
                            } else {
                              if (snapshot.data.result.productsDetails[0]
                                      .exitCart ==
                                  0) {
                                _allNetworking
                                    .add_new_product(
                                        id_product: snapshot
                                            .data.result.productsDetails[0].id,
                                        id_key: 1,
                                        token_id: token)
                                    .then((value) {
                                  setState(() {});
                                  print(value.message);
                                  Get.snackbar('', value.message);
                                });
                              } else {
                                Get.to(Shopping_Cart());
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            width: size.width ,
                            child: Center(
                              child: Text(
                                  snapshot.data.result.productsDetails[0]
                                              .exitCart ==
                                          0
                                      ? 'اضف الي العربة'
                                      : 'حذف من العربة',
                                  style: TextStyle(
                                      fontFamily: 'Arbf',
                                      color: Colors.white,
                                      fontSize: 25)),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
