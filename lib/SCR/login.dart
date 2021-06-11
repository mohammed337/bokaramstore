import 'package:bokaramstore/MyWidget/mybath.dart';
import 'package:bokaramstore/SCR/sginup.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/getdataromweb/push_notifcation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';
import 'homeScr.dart';

class LoginSCR extends StatefulWidget {
  @override
  _LoginSCRState createState() => _LoginSCRState();
}

class _LoginSCRState extends State<LoginSCR> {
  AllNetworking _allNetworking = AllNetworking();
  PushNotificationManagger _pushNotificationManagger =
      PushNotificationManagger();
  final box = GetStorage();
  String password1, phone;
  bool signup = false;
  String lang;

  @override
  Widget build(BuildContext context) {
    lang = box.read('lang');
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      child: CustomPaint(
                        size: Size(size.width, size.height * .6),
                        //You can Replace this with your desired WIDTH and HEIGHT
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    Positioned(
                        top: size.height * .01,
                        left: size.width * .1,
                        child: Column(
                          children: [SizedBox(height: size.height*.1,),
                            Container(
                              width: size.width * .8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                onChanged: (v) {
                                  phone = v;
                                },
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'phone'.tr,
                                    icon: Icon(Icons.person),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            Container(
                              width: size.width * .8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                onChanged: (v) {
                                  password1 = v;
                                },
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'password'.tr,
                                    focusedBorder: InputBorder.none,     icon: Icon(Icons.lock_open),
                                    enabledBorder: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            signup?CircularProgressIndicator():       GestureDetector(
                              onTap: () async {
                                setState(() {
                                  signup=true;
                                });
                                await _pushNotificationManagger
                                    .init()
                                    .then((firebasevalue) async {
                               print(firebasevalue);
                                  _allNetworking
                                      .login_account(
                                          phone: phone,
                                          password: password1,
                                      firebase_token: firebasevalue,
                                          lang: lang)
                                      .then((value) async {
                                    if (value.status) {
                                      await box.write('phone',
                                          value.result.customerInfo.phone);
                                      await box.write(
                                          'firebase_token', firebasevalue);
                                      await box.write('name',
                                          value.result.customerInfo.name);
                                      await box.write('token',
                                          value.result.customerInfo.tokenId);
                                      await box.write('email',
                                          value.result.customerInfo.email);
                                      await box.write(
                                          'id', value.result.customerInfo.id);
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     new MaterialPageRoute(
                                      //         builder: (context) => HomeSCR()),
                                      //     (Route<dynamic> route) => false);
                                    } else {
                                      Get.snackbar('', value.message);
                                      setState(() {
                                        signup=false;
                                      });  }
                                  });
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                child: Center(
                                  child: Text('login'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Arbf',
                                          color: Colors.grey,
                                          fontSize: 25)),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40.0)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Row(
                              children: [
                                Text(
                                  'BOKARAMSTORE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      'assets/images/log.png',
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            GestureDetector(
                              onTap: () {
                               // Get.to(HomeSCR());
                                Navigator.of(context).popUntil((route) => route.isFirst);     },
                              child: Container(
                                height: 50,
                                width: 200,
                                child: Center(
                                  child: Text('goto'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Arbf',
                                          color: Colors.grey,
                                          fontSize: 23)),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40.0)),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(SginUpSCR());
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text('savep'.tr,
                          style: TextStyle(
                              fontFamily: 'Arbf',
                              color: Colors.blue[800],
                              fontSize: 23)),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
