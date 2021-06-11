import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_contact_info_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  AllNetworking _allNetworking = AllNetworking();
  String name, email, phone, subject, message;
  bool sendmassge = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        top: true,
        child: Scaffold(appBar: AppBar(centerTitle: true,title: Text('call'.tr),),
          body: StreamBuilder<Get_contact_info_json>(
              stream: _allNetworking.get_contact_info(lang: 'ar').asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            onChanged: (v) {
                              name = v;
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            decoration: InputDecoration(
                                labelText: 'name'.tr,
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (v) {
                              email = v;
                            },
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            decoration: InputDecoration(
                                labelText: 'mail'.tr,
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            cursorColor: Colors.white,
                            onChanged: (v) {
                              phone = v;
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            decoration: InputDecoration(
                                labelText:'phone'.tr,
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (v) {
                              subject = v;
                            },
                            cursorColor: Colors.white,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            decoration: InputDecoration(
                                labelText: 'title'.tr,
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (v) {
                              message = v;
                            },
                            cursorColor: Colors.white,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            maxLines: 3,
                            decoration: InputDecoration(
                                labelText: 'message'.tr,
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor: Colors.grey,
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ),
                        ),
                        sendmassge
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  sendmassge = true;
                                  setState(() {});
                                  _allNetworking
                                      .create_message(
                                          lang: 'ar',
                                          name: name,
                                          phone: phone,
                                          email: email,
                                          subject: subject,
                                          message: message)
                                      .then((value) {
                                    print(value.toString());
                                    sendmassge = false;

                                    setState(() {});

                                    Get.snackbar('', value['message']);
                                  });
                                },
                                child: Container(
                                  height: size.height * .07,
                                  width: size.width * 0.5,
                                  child: Center(
                                    child: Text('send'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Arbf',
                                            color: Colors.white,
                                            fontSize: 25)),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                ),
                              ),
                        Wrap(
                          children: [
                            Text('address'.tr,
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  snapshot.data.result.contactInfo[0].address),
                            ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('phone'.tr,
                                  style: TextStyle(
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        'tel:${snapshot.data.result.contactInfo[0].mobile}');
                                  },
                                  child: Text(snapshot
                                      .data.result.contactInfo[0].mobile),
                                ),
                              )),
                            Text(' - '),Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        'tel:${snapshot.data.result.contactInfo[0].phone}');
                                  },
                                  child: Text(snapshot
                                      .data.result.contactInfo[0].phone),
                                ),
                            ),],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('mail'.tr,
                                  style: TextStyle(
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        'mailto:${snapshot.data.result.contactInfo[0].email}');
                                  },
                                  child: Text(snapshot
                                      .data.result.contactInfo[0].email),
                                ),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        'tel:${snapshot.data.result.contactInfo[0].mobile}');
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/what.png')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(snapshot
                                        .data.result.contactInfo[0].map);
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/address.png')),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       _launchURL(
                              //           'tel:${snapshot.data.result.contactInfo[0].hotline}');
                              //     },
                              //     child: Container(
                              //         height: 50,
                              //         width: 50,
                              //         child: Image.asset(
                              //             'assets/images/line.png')),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(snapshot
                                        .data.result.contactInfo[0].facebook);
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/facebook.png')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(snapshot
                                        .data.result.contactInfo[0].instagram);
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/insta.png')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(snapshot
                                        .data.result.contactInfo[0].twitter);
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/images/twi.png')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
