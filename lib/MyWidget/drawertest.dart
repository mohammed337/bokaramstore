import 'package:bokaramstore/SCR/about.dart';
import 'package:bokaramstore/SCR/contactus.dart';
import 'package:bokaramstore/SCR/homeScr.dart';
import 'package:bokaramstore/SCR/listOfCatSCR.dart';
import 'package:bokaramstore/SCR/login.dart';
import 'package:bokaramstore/SCR/myfavorite.dart';
import 'package:bokaramstore/SCR/myoldorder.dart';
import 'package:bokaramstore/Translation/Trans.dart';
import 'package:bokaramstore/Translation/lan/en.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_all_department_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';

Widget MyDrawertest(context, lang) {
  final GlobalKey expansionTileKey = GlobalKey();
  AllNetworking _allNetworking = AllNetworking();
  final box = GetStorage();
  String lang = box.read('lang');
  String token = box.read('token');
  if (lang == null) {
    lang = 'ar';
    box.write('lang', 'ar');
  }

  List<Widget> list = [];

  Widget listItem(
      {int index, String title, IconData icon, List<Departments> departments}) {
    return Material(
      color: Colors.transparent,
      child: Theme(
        data: ThemeData(accentColor: Colors.black),
        child: ExpansionTile(
          leading: Icon(
            icon,
            color: Colors.red,
            size: 20,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 17),
          ),
          children: <Widget>[
            for (int i = 0; i < departments.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    Get.to(ListOFDpScr(
                      id: departments[i].depId,
                      name: departments[i].depName,
                    ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.91,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 3),
                              color: Colors.grey[300],
                              blurRadius: 5),
                          BoxShadow(
                              offset: Offset(-1, -3),
                              color: Colors.grey[300],
                              blurRadius: 5)
                        ]),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: 22,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          departments[i].depName,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  return ClipRRect(
    borderRadius: lang == 'ar'
        ? BorderRadius.only(
            topLeft: Radius.circular(60), bottomLeft: Radius.circular(60))
        : BorderRadius.only(
            topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
    child: Drawer(
        child: FutureBuilder<Get_all_department_json>(
            future:
                _allNetworking.get_all_department(token_id: token, lang: lang),
            builder: (context, snapshot) {
              list.clear();
              if (snapshot.hasData) {
                for (int i = 0;
                    i < snapshot.data.result.categories.length;
                    i++) {
                  list.add(listItem(
                      title: snapshot.data.result.categories[i].categoryName,
                      icon: Icons.add,
                      departments:
                          snapshot.data.result.categories[i].departments));
                }
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomLeft: Radius.circular(60)),
                  child: Drawer(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.height * .2,
                              child: Image.asset(
                                'assets/images/log.png',
                                color: Colors.blue,
                              )),
                          ExpansionTile(
                            onExpansionChanged: (b) {
                              lang = box.read('lang');
                            },
                            leading: Container(
                              height: 35,
                              width: 35,
                              child: Image.asset(
                                'assets/images/categor.png',
                                // color: Colors.white,
                              ),
                            ),
                            title: Text('sections'.tr,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blue)),
                            children: [
                              ListView(
                                  shrinkWrap: true,
                                  primary: false,
                                  children: list),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // GestureDetector(
                          //      onTap: () {
                          //
                          //      },
                          //      child: Row(
                          //        children: [
                          //      Padding(
                          //      padding: const EdgeInsets.all(8),
                          //   child: Container(height: 50,width: 50,
                          //     child: Image.asset(
                          //       'assets/images/compare.png',
                          //       // color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          //          Padding(
                          //            padding: const EdgeInsets.all(8),
                          //            child: Text('?????????????????? (??????????)',
                          //                style: TextStyle(
                          //                    fontSize: 24, color: Colors.blue)),
                          //          ),
                          //        ],
                          //      )),
                          GestureDetector(
                              onTap: () {
                                Get.to(MyFavorite());
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 14, right: 14),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text('favorite'.tr,
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.blue)),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(OldOrders());
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 14, right: 14),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(
                                        'assets/images/shoppingcart.png',
                                        // color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text('order'.tr,
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.blue)),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(ContactUs());
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 14, right: 14),
                                    child: Icon(
                                      Icons.call,
                                      size: 35,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text('call'.tr,
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.blue)),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(About());
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 14, right: 14),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(
                                        'assets/images/about.png',
                                        // color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text('information'.tr,
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.blue)),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),

                          GestureDetector(
                              onTap: () async {
                                // Locale myLocale = Localizations.localeOf(context);
                                // print( Localizations.localeOf(context));
                                // print( Localizations.localeOf(context));
                                if (lang == 'en' || lang == null) {
                                  lang = 'ar';
                                  await LocalizationService()
                                      .changeLocale('ar');
                                  await box.write('lang', 'ar');
                                } else {
                                  lang = 'en';
                                  await LocalizationService()
                                      .changeLocale('en');
                                  await box.write('lang', 'en');
                                }

                                Navigator.of(context).pop();

                                print(lang);
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 14, right: 14),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(
                                        'assets/images/globe.png',
                                        // color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text('lan'.tr,
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.blue)),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          token != null
                              ? GestureDetector(
                                  onTap: () {
                                    _allNetworking
                                        .logout(lang: lang, token_id: token)
                                        .then((value) async {
                                      await box.remove('phone');
                                      await box.remove('firebase_token');
                                      await box.remove('name');

                                      await box.remove('token');
                                      await box.remove('email');
                                      await box.remove('id');

                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            left: 14,
                                            right: 14),
                                        child: Icon(
                                          Icons.exit_to_app,
                                          size: 35,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text('logout'.tr,
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.blue)),
                                      ),
                                    ],
                                  ))
                              : GestureDetector(
                                  onTap: () {
                                    Get.to(LoginSCR());
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            left: 14,
                                            right: 14),
                                        child: Icon(
                                          Icons.exit_to_app,
                                          size: 35,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text('login'.tr,
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.blue)),
                                      ),
                                    ],
                                  )),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  color: Colors.red,
                  child: Center(
                      child: Container(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  )),
                );
              }
            })),
  );
}
