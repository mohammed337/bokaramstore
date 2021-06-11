

import 'package:bokaramstore/MyWidget/customwidget.dart';
import 'package:bokaramstore/MyWidget/tabitem.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';
import 'package:bokaramstore/MyWidget/drawer.dart';
import 'package:bokaramstore/SCR/productDetails.dart';
import 'package:bokaramstore/SCR/profileScr.dart';
import 'package:bokaramstore/Translation/Trans.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_home_json.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'classification.dart';
import 'get_all_products_category.dart';
import 'homeScr.dart';
import 'login.dart';
import 'myfavorite.dart';
import 'notificationScr.dart';
import 'shoppingCart.dart';


class AllItems extends StatefulWidget {
  const AllItems({Key key}) : super(key: key);

  @override
  _AllItemsState createState() => _AllItemsState();
}

AllNetworking _allNetworking = AllNetworking();
List<Widget> itemSliders1 = [];
List<AllSliders> allSliders = [];
int selectedPosition = 0;
List<Widget> itemSliders2 = [];
List<AllSliders> allSliders2 = [];

List<Widget> itemSliders3 = [];
TextEditingController _textEditingController = TextEditingController();
int _selectedIndex = 0;
final box = GetStorage();
String token;
String lang;
AllFastFree offers;
List<Widget> serch = [];
bool serchbargetdata = false;
var local = Get.locale;
@override
void initState() {
  token = box.read('token');
  print(token);
  lang = box.read('lang');
  LocalizationService().changeLocale(lang);
}
class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    lang = box.read('lang');
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      drawer: DR(),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading:false,
        title: Container(
            width: size.width * .99,
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap:(){
                            Get.to(Shopping_Cart());
                          },
                          child: Icon(Icons.notification_important)),
                      GestureDetector(
                          onTap:(){
                            Get.to(NotificationScr());
                          },
                          child: Icon(Icons.shopping_bag)),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/images/log.png',
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CustomNotchedRectangle(),
        child: Builder(
          builder: (context) => Container(
            height: 80,
            child: Row(
              //    mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabItem(
                  text: "home".tr,
                  isSelected: selectedPosition == 0,
                  icon: Icons.home,
                  onPressed: () {
                   Navigator.pop(context);
               //   Get.to((HomeSCR()));
                  },
                ),
                TabItem(
                  text: 'favorite'.tr,
                  isSelected: selectedPosition == 1,
                  icon: Icons.favorite,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyFavorite()));
                    setState(() {
                      selectedPosition = 1;
                    });
                  },
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Classify()));
                    setState(() {
                      selectedPosition = 2;
                    });
                  },
                  child: Column(mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(width:50,height: 50,
                          child: Tab(icon:Image.asset("assets/images/apps.PNG",))),
                      Text('mainsections'.tr,style: TextStyle(
                          color: selectedPosition == 2 ? Colors.blue[800] : Colors.grey,
                          fontWeight: selectedPosition ==2 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 13
                      ))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openDrawer();
                  },
                  child: Column(mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(width:55,height: 55,
                          child: Tab(icon:Image.asset("assets/images/more.PNG",))),
                      Text('more'.tr,style: TextStyle(
                          color: selectedPosition== 3 ? Colors.blue[800] : Colors.grey,
                          fontWeight: selectedPosition==3 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 13
                      ))
                    ],
                  ),
                ),
                // TabItem(
                //   text: 'mainsections'.tr,
                //   isSelected: selectedPosition == 2,
                //   icon: Icons.apps,
                //   onPressed: () {
                //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Classify()));
                //     setState(() {
                //       selectedPosition = 2;
                //     });
                //   },
                // ),
                // TabItem(
                //     text: "more".tr,
                //     isSelected: selectedPosition == 3,
                //     icon: Icons.more_outlined,
                //     onPressed: () {
                //       Scaffold.of(context).openDrawer();
                //     }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            if (token == null) {
              Get.to(LoginSCR());
            } else {
              if (offers.exitCart == 0) {
                _allNetworking
                    .add_new_product(
                    id_product: int.parse(offers.offerId),
                    id_key: 1,
                    token_id: token)
                    .then((value) {
                  print(value.message);
                  setState(() {});
                  Get.snackbar('', value.message);
                });
              } else {
                Get.to(Shopping_Cart());
              }
            }
          },
          backgroundColor: Colors.blue[800],
          child: Icon(Icons.shopping_bag_outlined),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Container(child: myhomee(i: _selectedIndex, size: size)),
    );
  }
  Widget myhomee({int i, size}) {
    token = box.read('token');
    setState(() {});
    if (i == 0) {
      return StreamBuilder<Get_home_json>(
          stream:
          _allNetworking.Get_home(lang: lang, token_id: token).asStream(),
          builder: (context, snapshot) {
            var size = MediaQuery.of(context).size;
            if (snapshot.hasData) {

              for (int i = 0;
              i < snapshot.data.result.allPartners.length;
              i++) {
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
                    height: size.height * .1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        snapshot.data.result.allPartners[i].imageCateg,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ));
              }

              int currentIndex;
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverGrid(delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Get.to(ProductDetails(
                                        snapshot.data.result.allOffers[index]
                                            .offerId,
                                        product_name: snapshot.data.result
                                            .allOffers[index].offerName));
                                  },
                                  child: offersiteem(
                                      size: size,
                                      offers: snapshot
                                          .data.result.allOffers[index]));
                            },
                            childCount: snapshot.data.result.allOffers.length,
                          ),
                          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          //   maxCrossAxisExtent: 200.0,
                          //   mainAxisSpacing: 10.0,
                          //   crossAxisSpacing: 10.0,
                          //   childAspectRatio: 4.0,
                          // ),
                          gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: size.width * .5,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            //  childAspectRatio: 4.0,
                            mainAxisExtent: 450,
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(
                              height: 2,
                            )),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Container(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator()),
              );
            }
          });
    }
  }
  Widget offersiteem({AllOffers offers, size}) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Share.share(
                            offers.sharelink,
                          );
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.red,
                        )),

                    GestureDetector(
                      onTap: () {
                        token == null
                            ? Get.to(LoginSCR())
                            : _allNetworking
                            .update_myfavorite(
                            id_product: int.parse(offers.offerId),
                            id_key: offers.favExit == 0 ? 1 : 2,
                            token_id: token)
                            .then((value) {
                          setState(() {});
                          Get.snackbar('', value.message);
                        });
                      },
                      child: Icon(
                        offers.favExit == 0
                            ? Icons.favorite_border
                            : Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Colors.red ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "%" + offers.discountPercentage+ " - " ,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
            Image.network(
              offers.imageCateg,
              fit: BoxFit.fill,
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: 200,
              child: Text(
                offers.offerName,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.right,
                maxLines: 1,
                softWrap: true,
              ),
            ),
            Row(
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
                    initialRating: offers.totalRate.trim().isEmpty
                        ? 0.0
                        : double.tryParse(offers.totalRate),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child:
                      Text(offers.newPrice + " " + offers.currencyName ?? " "),
                    )),
                Text("/"),
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
                        ),
                        Text(
                          offers.oldPrice + " " + offers.currencyName ?? " ",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    )),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (token == null) {
                      Get.to(LoginSCR());
                    } else {
                      if (offers.exitCart == 0) {
                        _allNetworking
                            .add_new_product(
                            id_product: int.parse(offers.offerId),
                            id_key: 1,
                            token_id: token)
                            .then((value) {
                          print(value.message);
                          setState(() {});
                          Get.snackbar('', value.message);
                        });
                      } else {
                        Get.to(Shopping_Cart());
                      }
                    }
                  },
                  child: Container(
                    width: 145,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                'assets/images/addbasket.png',
                                color: Colors.blue[600],
                              )),
                          Text(offers.exitCart == 0 ? 'addpro'.tr : 'delpro'.tr,
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
                GestureDetector(
                  onTap: () async {
                    final link = WhatsAppUnilink(
                      phoneNumber: offers.whatsapp,
                      text: 'طلب منتج ${offers.offerName} ' +
                          'بسعر ${offers.newPrice} ',
                    );
                    // Convert the WhatsAppUnilink instance to a string.
                    // Use either Dart's string interpolation or the toString() method.
                    // The "launch" method is part of "url_launcher".
                    await launch('$link');
                  },
                  child: Container(
                      height: 45,
                      width: 37,
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
            ),




            // GestureDetector(
            //   onTap: () async {
            //     final link = WhatsAppUnilink(
            //       phoneNumber: offers.whatsapp,
            //       text: 'طلب منتج ${offers.offerName} ' +
            //           'بسعر ${offers.newPrice} ',
            //     );
            //     // Convert the WhatsAppUnilink instance to a string.
            //     // Use either Dart's string interpolation or the toString() method.
            //     // The "launch" method is part of "url_launcher".
            //     await launch('$link');
            //   },
            //   child: Container(
            //       height: 35,
            //       width: 35,
            //       child: Image.asset(
            //         'assets/images/what.png',
            //         // color: Colors.blue[800],
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}
