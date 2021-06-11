import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'SCR/homeScr.dart';
import 'SCR/login.dart';
import 'Translation/Trans.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp( locale: LocalizationService.locale,debugShowCheckedModeBanner: false,
        translations: LocalizationService(),
        fallbackLocale: LocalizationService.fallbackLocale,
      title: 'Flutter Demo',
      theme:   ThemeData(
      fontFamily: 'Arbf',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
      home: HomeSCR()
    );
  }
}
