import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro/pages/Home.dart';
import 'package:pro/services/service_locator.dart';

import 'Controller/MyBinding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => Home(), binding: MyBinding()),
    ],
    title: "البروالصلة والآداب",
    textDirection: TextDirection.rtl,
    debugShowCheckedModeBanner: false,
  ));
}
