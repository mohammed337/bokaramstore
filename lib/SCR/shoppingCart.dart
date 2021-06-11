import 'package:bokaramstore/SCR/login.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_cart_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'myorder.dart';

class Shopping_Cart extends StatefulWidget {
  @override
  _Shopping_CartState createState() => _Shopping_CartState();
}

class _Shopping_CartState extends State<Shopping_Cart> {
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String token;
  String lang;

  @override
  void initState() {
    token = box.read('token');
    lang = box.read('lang');
  }

  @override
  Widget build(BuildContext context) {
    print(token);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body:token!=null?  StreamBuilder<Get_cart_json>(
          stream:
              _allNetworking.get_cart(lang: lang, token_id: token).asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.result.orderDetails.length > 0) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.result.allProducts.length,
                          itemBuilder: (context, pos) {
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                height: size.height * .25,
                                width: size.width,
                                child: Center(
                                    child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blueAccent
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          height: size.height * .2,
                                          width: size.width * .9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  snapshot.data.result
                                                      .allProducts[pos].image,
                                                  width: size.width * .3,
                                                  height: size.height * .15,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, bottom: 2),
                                                child: Column(
                                                  children: [
                                                    SingleChildScrollView(
                                                      child: Container(
                                                        height:
                                                            size.height * .1,
                                                        width: size.width * .3,
                                                        child: Text(snapshot
                                                            .data
                                                            .result
                                                            .allProducts[pos]
                                                            .productName),
                                                      ),
                                                    ),
                                                    Text(snapshot
                                                            .data
                                                            .result
                                                            .allProducts[pos]
                                                            .price +
                                                        '  ' +
                                                        snapshot
                                                            .data
                                                            .result
                                                            .allProducts[pos]
                                                            .currencyName)
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _allNetworking
                                                            .update_order(
                                                                id_product: snapshot
                                                                    .data
                                                                    .result
                                                                    .allProducts[
                                                                        pos]
                                                                    .idProduct,
                                                                id_key: 1,
                                                                token_id: token,
                                                                lang: 'ar',
                                                                id_order: snapshot
                                                                    .data
                                                                    .result
                                                                    .orderDetails[
                                                                        0]
                                                                    .idOrder,
                                                                quantity_new: 1)
                                                            .then((value) {
                                                          setState(() {});

                                                          Get.snackbar('',
                                                              value.message);
                                                        });
                                                      },
                                                      child: Text('+',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Text(
                                                        snapshot
                                                            .data
                                                            .result
                                                            .allProducts[pos]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _allNetworking
                                                            .update_order(
                                                                id_product: snapshot
                                                                    .data
                                                                    .result
                                                                    .allProducts[
                                                                        pos]
                                                                    .idProduct,
                                                                id_key: 2,
                                                                token_id: token,
                                                                lang: 'ar',
                                                                id_order: snapshot
                                                                    .data
                                                                    .result
                                                                    .orderDetails[
                                                                        0]
                                                                    .idOrder,
                                                                quantity_new: 1)
                                                            .then((value) {
                                                          setState(() {});
                                                          Get.snackbar('',
                                                              value.message);
                                                        });
                                                      },
                                                      child: Text('-',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                        top: size.height * .01,
                                        right: size.width * 0.05 - 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            _allNetworking
                                                .add_new_product(
                                                    id_product: snapshot
                                                        .data
                                                        .result
                                                        .allProducts[pos]
                                                        .idProduct,
                                                    id_order: snapshot
                                                        .data
                                                        .result
                                                        .orderDetails[0]
                                                        .idOrder,
                                                    id_key: 2,
                                                    token_id: token)
                                                .then((value) {
                                              setState(() {});
                                              Get.snackbar('', value.message);
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            color: Colors.red,
                                            child: Center(
                                                child: Text('X',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ),
                                        ))
                                  ],
                                )),
                              ),
                            );
                          }),
                    ),
                    Container(
                      child: Center(
                        child: snapshot.data.result.orderDetails.length > 0
                            ? Text(
                                '${snapshot.data.result.orderDetails[0].totalPrice + " " + snapshot.data.result.orderDetails[0].currencyName}' +
                                    'التكلفة الكلية ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              )
                            : Text(
                                'التكلفه الكلية 0',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                      ),
                    ),
                    snapshot.data.result.orderDetails.length > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        _allNetworking
                                            .empty_cart(
                                                lang: 'ar',
                                                token_id: token,
                                                id_order: snapshot.data.result
                                                    .orderDetails[0].idOrder)
                                            .then((value) {
                                          Get.snackbar('', value.message);
                                          setState(() {});
                                        });
                                      },
                                      child: Text('افراغ السلة',
                                          style: TextStyle(
                                              fontFamily: 'Arbf',
                                              color: Colors.white,
                                              fontSize: 23)),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[800],
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        print(snapshot.data.result
                                            .orderDetails[0].idOrder);
                                        Get.to(Myorder(snapshot.data.result
                                            .orderDetails[0].idOrder));
                                      },
                                      child: Text('عمل الطلب',
                                          style: TextStyle(
                                              fontFamily: 'Arbf',
                                              color: Colors.white,
                                              fontSize: 23)),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[800],
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                ),
                              ),
                            ],
                          )
                        : SizedBox()
                  ],
                );
              } else {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      'assets/images/emptycart.png',
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: Container(width: 100,height: 100,child: CircularProgressIndicator()),
              );;
            }
          }):Container(
        child: Center(
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
      )
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
// Center(
// child: Stack(
// children: <Widget>[
// //...bottom card part,
// Container(
// width: MediaQuery.of(context).size.width * .9,
// padding: EdgeInsets.only(
// top:20,
//
// ),
// margin: EdgeInsets.only(top:10),
// decoration: new BoxDecoration(
// color: Colors.white,
// shape: BoxShape.rectangle,
// borderRadius: BorderRadius.circular(Consts.padding),
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// blurRadius: 10.0,
// offset: const Offset(0.0, 10.0),
// ),
// ],
// ),
// child: Column(
// mainAxisSize: MainAxisSize.min, // To make the card compact
// children: <Widget>[
// Text(
// '0000',
// style: TextStyle(
// fontSize: 24.0,
// fontWeight: FontWeight.w700,
// ),
// ),
// SizedBox(height: 16.0),
// Text(
// '0000000000',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 16.0,
// ),
// ),
// SizedBox(height: 24.0),
// SizedBox(height: 24.0),
// ],
// ),
// ),
// Positioned(
// bottom: 10,
// left: 10,
// child: GestureDetector( onTap: (){},
// child: Container(width: 50,height: 30,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(7), //border corner radius
// boxShadow:[
// BoxShadow(
// color: Colors.grey.withOpacity(0.5), //color of shadow
// spreadRadius: 5, //spread radius
// blurRadius: 7, // blur radius
// offset: Offset(0, 2), // changes position of shadow
// //first paramerter of offset is left-right
// //second parameter is top to down
// ),
// //you can set more BoxShadow() here
// ],
// ),
// child: Center(child: Text("buttonText2")),
// ),
// ),
// ),
// Positioned(
// bottom: 10,
// right: MediaQuery.of(context).size.width*.35   ,
// child: GestureDetector( onTap: (){Navigator.of(context, rootNavigator: true)
//     .pop();},
// child: Container(width: 50,height: 30,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(7), //border corner radius
// boxShadow:[
// BoxShadow(
// color: Colors.grey.withOpacity(0.5), //color of shadow
// spreadRadius: 5, //spread radius
// blurRadius: 7, // blur radius
// offset: Offset(0, 2), // changes position of shadow
// //first paramerter of offset is left-right
// //second parameter is top to down
// ),
// //you can set more BoxShadow() here
// ],
// ),
// child: Center(child: Text("buttonText")),
// ),
// ),
// ),
// Positioned(
// // left: 0,
// right: -5,top: 5,
// child: Container(height: 20,width: 20,color: Colors.red,),
// ),
// //...top circlular image part,
// ],
// ),
// );
