import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/city_json.dart';
import 'package:bokaramstore/jsondata/get_cities_json.dart';
import 'package:bokaramstore/jsondata/preparation_profile_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'login.dart';

class ProfileScr extends StatefulWidget {
  @override
  _ProfileScrState createState() => _ProfileScrState();
}

class _ProfileScrState extends State<ProfileScr> {
  final box = GetStorage();
  String token;
  AllNetworking _allNetworking = AllNetworking();

  String lang;


  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  List<Kind> list = [Kind("man".tr, '0'), Kind("woman".tr, '1')];
  Kind _kind;
  List<CityDetailsprofile>citylist = [];
  CityDetailsprofile _cityDetailsprofile;
String hintsex='';
  String hintcety='';
  bool savedata=false;
  @override
  void initState() {
    token = box.read('token');
    lang = box.read('lang');
    _allNetworking
        .get_cities(lang: lang, token_id: token)
        .then((value) {
      for (int i = 0; i < value.result.cityDetails.length; i++) {
        citylist.add(CityDetailsprofile(
            cityName: value.result.cityDetails[i].cityName,
            cityId: value.result.cityDetails[i].cityId));
      //  print(value.result.cityDetails[i].cityName);
      }
      setState(() {

      });
    }


    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<Preparation_profile_json>(
          stream: _allNetworking
              .preparation_profile(lang: lang, token_id: token)
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              name.text = snapshot.data.result.customerInfo.name;
              phone.text = snapshot.data.result.customerInfo.phone;
              address.text = snapshot.data.result.customerInfo.address;
              email.text = snapshot.data.result.customerInfo.email;
for(int i=0;i<list.length;i++){
  if(list[i].kindkey==snapshot.data.result.customerInfo.sex){
    hintsex=list[i].kind;
  }}
    for(int i=0;i<citylist.length;i++){

    if(citylist[i].cityId==int.tryParse(snapshot.data.result.customerInfo.cityId)){
    hintcety=citylist[i].cityName;
    }
}
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Myinput(
                          hint: 'name'.tr,
                          inputtype: TextInputType.name,
                          textEditingController: name),
                      SizedBox(
                        height: 8,
                      ),
                      Myinput(
                          hint: 'phone'.tr,
                          textEditingController: phone,
                          inputtype: TextInputType.phone),
                      SizedBox(
                        height: 8,
                      ),
                      Myinput(
                          hint: 'mail'.tr,
                          textEditingController: email,
                          inputtype: TextInputType.emailAddress),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //         <--- border radius here
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Type'.tr),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            DropdownButton<Kind>(
                              value: _kind,hint: Text(hintsex),
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (Kind newValue) {
                                setState(() {
                                  _kind = newValue;
                                });
                              },
                              items: list.map<DropdownMenuItem<Kind>>(
                                      (Kind value) {
                                    return DropdownMenuItem<Kind>(
                                      value: value,
                                      child: Text(value.kind),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //         <--- border radius here
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('city'.tr),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            DropdownButton<CityDetailsprofile>(
                              value: _cityDetailsprofile,hint: Text(hintcety),
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (CityDetailsprofile newValue) {
                                setState(() {
                                  _cityDetailsprofile = newValue;
                                });
                              },
                              items: citylist.map<
                                  DropdownMenuItem<CityDetailsprofile>>(
                                      (CityDetailsprofile value) {
                                    return DropdownMenuItem<CityDetailsprofile>(
                                      value: value,
                                      child: Text(value.cityName),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Myinput(
                          hint: 'address'.tr,
                          inputtype: TextInputType.name,
                          textEditingController: address),
                      SizedBox(
                        height: 8,
                      ),
                      Myinput(
                          hint: 'password'.tr, inputtype: TextInputType.name)
                      ,   SizedBox(
                        height: 8,
                      ), savedata? Center(
                  child: Container(width: 100,height: 100,child: CircularProgressIndicator()),
                ) :GestureDetector(
                        onTap: () {


                          _allNetworking.edit_profile(phone: phone.text,
                              token_id: token,
                              lang: lang,

                              city_id: _cityDetailsprofile==null?snapshot.data.result.customerInfo.cityId:_cityDetailsprofile.cityId

                              ,
                              address: address.text,

                              fullname: name.text,
                              email: email.text,
                              password: password.text,
                              sex: _kind==null?snapshot.data.result.customerInfo.sex:_kind.kindkey).then((value) {
                                setState(() {

                                });
                              Get.snackbar('', value.message);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Center(
                            child: Text('save'.tr,
                                style: TextStyle(
                                    fontFamily: 'Arbf',
                                    color: Colors.white,
                                    fontSize: 23)),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue
                              ,
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(width: 100,height: 100,child: CircularProgressIndicator()),
              );
            }
          })

    );
  }

  Widget Myinput(
      {hint, inputtype, TextEditingController textEditingController}) {
    return TextFormField(
      keyboardType: inputtype,
      textAlign: TextAlign.center,
      maxLines: null,
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Arbf',
          color: Colors.grey,
        ),
      ),
    );
  }
}

class Kind {
  String kind;

  Kind(this.kind, this.kindkey);

  String kindkey;
}
