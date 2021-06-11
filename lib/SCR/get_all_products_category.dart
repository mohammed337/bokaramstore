import 'package:bokaramstore/SCR/login.dart';
import 'package:bokaramstore/SCR/productDetails.dart';
import 'package:bokaramstore/SCR/shoppingCart.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_all_products_category_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
class Get_All_Products_Category extends StatefulWidget {
  String id;
  String name;


  Get_All_Products_Category({this.id, this.name});

  @override
  _Get_All_Products_CategoryState createState() => _Get_All_Products_CategoryState();
}

class _Get_All_Products_CategoryState extends State<Get_All_Products_Category> {
  AllNetworking _allNetworking = AllNetworking();
  ScrollController _scrollController;
  int sizelist = 0;
  int limit = 50;
  final box = GetStorage();
  String token;
  String lang;

  @override
  void initState() {
    super.initState();
    token = box.read('token');
    lang = box.read('lang');
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.8;
    final double itemWidth = size.width / 2;
    return SafeArea(
      top: true,
      child: Scaffold(appBar: AppBar(centerTitle: true,title: Text(widget.name),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<Get_all_products_category_json>(
                  stream: _allNetworking
                      .get_all_products_category(
                      page_number: 0,token_id: token,
                      limit: limit,
                      lang: lang,
                      dep_id: widget.id)
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return Column(
                        children: [
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .2,
                            child:
                            Image.network(snapshot.data.result.categoryImg),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .7,
                            child: GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: size.width * .5,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                //  childAspectRatio: 4.0,
                                mainAxisExtent: 470,
                              ),
                              itemCount: snapshot.data.result.allProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Productsiteem(
                                    offers:
                                    snapshot.data.result.allProducts[index],size: size);
                              },
                            ),
                          ),
                      ],
                      );
                    } else {
                      return Center(
                        child: Container(width: 100,height: 100,child: CircularProgressIndicator()),
                      );
                    }
                  }),
          ],
          ),
        ),
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (sizelist > 8) {
        limit = limit + 20;
        setState(() {});
        // getallp(
        //     limit: limit.toString().toString(),
        //     page_number: 0.toString(),
        //     token_id: token,
        //     phone: phone);
      }
    }
  }

  Widget Productsiteem({AllProducts offers,size}) {
    print('000000000000000000000000000000000000000000000000000000000000');
    print(offers.totalRate);

    print('000000000000000000000000000000000000000000000000000000000000');
    bool desc = (offers.discountPercentage != '0');

    return GestureDetector(onTap: (){
      Get.to(ProductDetails(offers.offerId));
    },
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
          mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(onTap: (){
                       Share.share(offers.shareLink);
                      },child: Icon(Icons.share,color: Colors.red,)),
                      GestureDetector(
                        onTap: (){
                          token==null? Get.to(LoginSCR()):
                          _allNetworking
                              .update_myfavorite(lang: 'ar',
                              id_product:int.parse(offers.offerId ),
                              id_key:  offers.favExit==0? 1:2,
                              token_id: token)
                              .then((value) {
                            setState(() {

                            });
                            Get.snackbar('', value.message);
                          });

                        },
                        child: Icon(
                          offers.favExit==0?  Icons.favorite_border:Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  desc ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "%" + offers.discountPercentage,
                              style: TextStyle(color: Colors.red),
                            ),
                          )),
                    ],
                  ) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),    ],//'FREEDELIVERY'.tr
              ),

            Image.network(
              offers.imageCateg,
              fit: BoxFit.fill, height: 200,
              width: 200,
            ),       Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RatingBar(
                      // onRatingChanged: (rating) {
                      //   _rating = rating;
                      //   print(snapshot
                      //       .data.result.productsDetails[0].id);
                      //   _allNetworking
                      //       .add_review(
                      //       product_id: snapshot.data.result
                      //           .productsDetails[0].id,
                      //       rating: rating.toInt(),
                      //       token_id: token,
                      //       lang: 'ar')
                      //       .then((value) {
                      //     Get.snackbar('', value.message);
                      //     setState(() {});
                      //   });
                      // },
                      filledIcon: Icons.star,
                      initialRating:  offers.totalRate .trim().isEmpty?0.0:double.tryParse(offers.totalRate ),
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: true,
                      filledColor: Colors.green,
                      emptyColor: Colors.redAccent,
                      halfFilledColor: Colors.amberAccent,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(offers.offerName,textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,),
                  )),
              desc
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Text(offers.newPrice + " " + offers.currencyName),
                      )),

                  Container(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 12,
                            child: Container(
                              height: 2,
                              width: 80,
                              color: Colors.grey,
                            ),
                          ), Text(offers.oldPrice + " " + offers.currencyName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey)),

                        ],
                      ))
                 ,
                ],
              )
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(offers.newPrice),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {    if(  token == null){
                      Get.to(LoginSCR());
                    }else{
                      if(offers.exitCart==0){
                        _allNetworking
                            .add_new_product(
                            id_product:int.parse(offers.offerId) ,
                            id_key: 1,
                            token_id: token)
                            .then((value) {
                          setState(() {

                          });
                          Get.snackbar('', value.message);
                        });
                      }else{Get.to(Shopping_Cart());}
                    }}
                    ,
                    child: Container(
                      width:  MediaQuery.of(context).size.width* .33,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width* .05,
                              child: Image.asset(
                                'assets/images/addbasket.png',
                                color: Colors.blue[600],
                              )),
                            Text(offers.exitCart==0  ? 'addpro'.tr
                                : 'delpro'.tr,
                                style: TextStyle(
                                  fontFamily: 'Arbf',
                                  color: Colors.blue[600],
                                )),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                            // topRight:Radius.circular(20)
                          )),
                    ),
                  ),
                  GestureDetector(onTap: ()async{
                    final link = WhatsAppUnilink(
                      phoneNumber: offers.whatsapp,
                      text: 'طلب منتج ${ offers.offerName } '+'بسعر ${ offers.newPrice } ',
                    );
                    // Convert the WhatsAppUnilink instance to a string.
                    // Use either Dart's string interpolation or the toString() method.
                    // The "launch" method is part of "url_launcher".
                    await launch('$link');
                  },
                    child:  Container(
                        height: 45,
                        width:      MediaQuery.of(context).size.width* .08,
                        decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),

                        child: Image.asset(
                          'assets/images/what2.png',
                          // color: Colors.blue[800],
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
