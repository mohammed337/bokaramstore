import 'package:bokaramstore/MyWidget/customwidget.dart';
import 'package:bokaramstore/MyWidget/tabitem.dart';
import 'package:bokaramstore/SCR/productDetails.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_all_myfavorite_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'homeScr.dart';
import 'login.dart';
class MyFavorite extends StatefulWidget {
  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  AllNetworking _allNetworking = AllNetworking();
  ScrollController _scrollController;
  int sizelist = 0;
  int limit = 10;
  final box = GetStorage();
  String token;
  int selectedPosition = 1;
  @override
  void initState() {
    super.initState();
    token = box.read('token');
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
      child: Scaffold(
        appBar: AppBar(
          title: Text('favorite'.tr),centerTitle: true,),
        body:token!=null?
            StreamBuilder<Get_all_myfavorite_json>(
                stream: _allNetworking
                    .get_all_myfavorite(lang: 'ar', limit: limit, page_number: 0, token_id: token)
                    .asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.result.allFavourites);

                    return GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                      SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: size.width * .5,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        //  childAspectRatio: 4.0,
                        mainAxisExtent: 380,
                      ),
                      itemCount: snapshot.data.result.allFavourites.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Productsiteem(
                            offers:
                            snapshot.data.result.allFavourites[index]);
                      },
                    );
                  } else {
                    return Center(
                      child: Container(width: 100,height: 100,child: CircularProgressIndicator()),
                    );;
                  }
                }):Center(
          child: GestureDetector(
          onTap: () {
     Get.to(LoginSCR());
     },
       child: Container(
         height: 50,
         width: 200,
         child: Center(
           child: Text( 'savep'.tr,
               style: TextStyle(
                   fontFamily: 'Arbf',
                   color: Colors.white,
                   fontSize: 23)),
         ),
         decoration: BoxDecoration(color:  Colors.blue[800],
             borderRadius: BorderRadius.circular(40.0)),
       ),
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

  Widget Productsiteem({AllFavourites offers}) {
    print('000000000000000000000000000000000000000000000000000000000000');
    print(offers.discountPercentage);

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
              Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  GestureDetector(onTap: (){
                    _allNetworking
                        .update_myfavorite(
                        id_product: int.parse(offers.offerId),
                        id_key: 2,
                        token_id: token)
                        .then((value) {
                      setState(() {

                      });
                      Get.snackbar('', value.message);
                    });
                  },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ) ,Text('delivery'.tr),],
              ),
              desc
                  ? Row(
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
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/offer.png',
                       // color: Colors.blue[800],
                      )),
                ],
              )
                  : SizedBox(),
              Expanded(

                child: Container(
                  child: Image.network(
                    offers.imageCateg,
                    fit: BoxFit.fill,
                  ),
                ),

              ),
              Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(offers.offerName),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Text(offers.oldPrice + " " + offers.currencyName),
                      )),
                ],
              )
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(offers.newPrice),
              ),
              GestureDetector(


                onTap: () {    if(  token == null){
                  Get.to(LoginSCR());
                }else{
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

                }}
                ,
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('addpro'.tr,
                              style: TextStyle(
                                fontFamily: 'Arbf',
                                color: Colors.white,
                              )),
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                'assets/images/addbasket.png',
                                color: Colors.white,
                              )),    ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(40.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//
//
//
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// GestureDetector(onTap: (){
// _allNetworking
//     .update_myfavorite(
// id_product: int.parse(offers.offerId),
// id_key: 2,
// token_id: token)
//     .then((value) {
// print(value.message);
// Get.snackbar('', value.message);
// });
// },
// child: Icon(
// Icons.delete,
// color: Colors.red,
// ),
// ),
// SizedBox()
// ],
// ),