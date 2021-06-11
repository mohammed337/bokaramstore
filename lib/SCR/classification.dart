import 'package:bokaramstore/MyWidget/customwidget.dart';
import 'package:bokaramstore/MyWidget/my_flutter_app_icons.dart';
import 'package:bokaramstore/MyWidget/tabitem.dart';
import 'package:bokaramstore/SCR/homeScr.dart';
import 'package:bokaramstore/jsondata/get_all_department_json.dart';
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
import 'get_all_products_category.dart';
import 'listOfCatSCR.dart';
import 'login.dart';
import 'myfavorite.dart';
import 'notificationScr.dart';
import 'shoppingCart.dart';
class Classify extends StatefulWidget {
  const Classify({Key key}) : super(key: key);

  @override
  _ClassifyState createState() => _ClassifyState();
}

AllNetworking _allNetworking = AllNetworking();

int selectedPosition =2 ;
List<Widget> itemSliders2 = [];
List<AllSliders> allSliders2 = [];


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
class _ClassifyState extends State<Classify> {
  @override
  Widget build(BuildContext context) {
    lang = box.read('lang');
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      drawer: DR(),
      //MyDrawertest(context, lang), //MyDrawer(context),
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
                          child: Icon(Icons.notification_important,size: 28,)),

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
            height: 75,
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
                    setState(() {
                      selectedPosition = 0;
                    });
                  },
                ),
                TabItem(
                  text: 'favorite'.tr,
                  isSelected: selectedPosition == 1,
                  icon: Icons.favorite,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyFavorite()));
                    setState(() {
                      selectedPosition = 1;
                    });
                  },
                ),
                SizedBox(
                  width: size.width * .13,
                ),
                TabItem(
                  text: 'mainsections'.tr,
                  isSelected: selectedPosition == 2,
                  icon: MyFlutterApp.categories,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Classify()));
                    setState(() {
                      selectedPosition = 2;
                    });
                  },
                ),
                SizedBox(
                  width: size.width * .07,
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
                SizedBox(
                  width: size.width * .01,
                ),


              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
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
              //c
              for (int i = 0; i < snapshot.data.result.allCategories.length;i++) {
                itemSliders2.add(GestureDetector(
                  onTap: () async{
                    print(snapshot.data.result.allCategories[i].categoryId);
                    print(snapshot.data.result.allCategories[i].categoryName);
                    await Get.to(Get_All_Products_Category(
                      id: snapshot.data.result.allCategories[i].categoryId,
                      name: snapshot.data.result.allCategories[i].categoryName,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // width:  size.width,
                        // height: size.height * .15, width: size.height * .2,
                        Expanded(
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                snapshot.data.result.allCategories[i].imageCateg,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              snapshot.data.result.allCategories[i].categoryName,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
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
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text('Classifications'.tr,
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.grey[600])),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(
                              height: 1.8,
                            )),
                        SliverFixedExtentList(
                          itemExtent: size.height * .6,
                          delegate: SliverChildListDelegate([
                            Container(
                              child: CarouselSlider(
                                items: itemSliders2,
                                options: CarouselOptions(
                                  disableCenter: true,
                                  scrollDirection: Axis.vertical,
                                  viewportFraction: .7,
                                  aspectRatio: .40,
                                  enlargeCenterPage: true,
                                ),
                              ),
                            ),
                          ]),
                        ),
                        // SliverGrid(delegate: SliverChildBuilderDelegate(
                        //       (itemSliders2, index) {
                        //     return GestureDetector(
                        //         onTap: () {
                        //           print(snapshot.data.result.allCategories[i].categoryId);
                        //           print(snapshot.data.result.allCategories[i].categoryName);
                        //           // Get.to(Get_All_Products_Category(
                        //           //   id: snapshot.data.result.allCategories[i].categoryId,
                        //           //   name: snapshot.data.result.allCategories[i].categoryName,
                        //           // ));
                        //         },
                        //         child: offersiteem(size: size,
                        //             offers: snapshot.data.result.allCategories[index]));
                        //   },
                        //   childCount: snapshot.data.result.allCategories.length,
                        // ),
                        //   // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        //   //   maxCrossAxisExtent: 200.0,
                        //   //   mainAxisSpacing: 10.0,
                        //   //   crossAxisSpacing: 10.0,
                        //   //   childAspectRatio: 4.0,
                        //   // ),
                        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        //     maxCrossAxisExtent: size.width * .5,
                        //     mainAxisSpacing: 5.0,
                        //     crossAxisSpacing: 1.0,
                        //     //  childAspectRatio: 4.0,
                        //     mainAxisExtent: 300,
                        //   ),
                        // ),
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
  Widget offersiteem({AllCategories offers, size}) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
              child: Center(
                child: Text(
                  offers.categoryName,
                  style: TextStyle(fontSize: 25),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  softWrap: true,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}






