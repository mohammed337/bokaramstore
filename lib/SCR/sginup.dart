import 'package:bokaramstore/MyWidget/mybath.dart';
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/getdataromweb/push_notifcation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'login.dart';

class SginUpSCR extends StatefulWidget {
  @override
  _SginUpSCRState createState() => _SginUpSCRState();
}

class _SginUpSCRState extends State<SginUpSCR> {
  AllNetworking _allNetworking = AllNetworking();
  PushNotificationManagger _pushNotificationManagger =
  PushNotificationManagger();
  final box = GetStorage();
  String name,password1,password2,phone,maile;
  bool signup=false;
  @override
  Widget build(BuildContext context) {
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
                        size: Size(size.width, size.height * .25),
                        //You can Replace this with your desired WIDTH and HEIGHT
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    Positioned(
                        top: size.height * .1,
                        left: size.width * .25,
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(LoginSCR());
                              },
                              child: Text('تسجيل الدخول',
                                  style: TextStyle(
                                      fontFamily: 'Arbf',
                                      color: Colors.white,
                                      fontSize: 23)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(40.0)),
                        )),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BOKARAMSTORE',
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          'assets/images/log.png',
                          color: Colors.blue[800],
                        ))
                  ],
                ),
                Container(
                  height: 50,
                  width: 200,
                  child: Center(
                    child: Text('انشاء حساب',
                        style: TextStyle(
                            fontFamily: 'Arbf',
                            color: Colors.blue[800],
                            fontSize: 23)),
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
                ),
                Column(
                  children: [
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(onChanged: (v){
                        name=v;
                      },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'name'.tr,
                            icon: Icon(Icons.person),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ), SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(onChanged: (v){
                        phone=v;
                      },
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'phone'.tr,
                            icon: Icon(Icons.phone),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ), SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(onChanged: (v){
                        maile=v;
                      },
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'mail'.tr,
                            icon: Icon(Icons.alternate_email),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(onChanged: (v){
                        password1=v;
                      },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'password'.tr,
                            icon: Icon(Icons.lock_open),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(onChanged: (v){
                        password2=v;
                      },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText:  'password2'.tr,
                            icon: Icon(Icons.lock_open),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    signup?Center(
                      child: Container(width: 100,height: 100,child: CircularProgressIndicator()),
                    ):    GestureDetector(onTap: ()async{
                      if( password1!=null&& password1!=null&& phone!=null&& maile!=null){

                        if(password1==password2){
                          await _allNetworking.create_account(
                              phone: phone,password: password1,name: name,email: maile,
                              lang: 'ar')
                              .then((value) async {

                            Get.snackbar('',value.message,);
                            Get.to(LoginSCR());
                            signup = false;
                            setState(() {});
                          });


                        }
                        else{
                          Get.snackbar('', 'كلمة السر غير متطابقه');
                        }

                      }else{
                        Get.snackbar('', 'برجاء ادخال البيانات');
                      }



                    },
                      child: Container(
                        height: 50,
                        width: 200,
                        child: Center(
                          child: Text('انشاء',
                              style: TextStyle(
                                  fontFamily: 'Arbf',
                                  color: Colors.white,
                                  fontSize: 25)),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
