import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DB/Data.dart';

class MyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? animationController;
  RxBool drawerOpen = false.obs;
  DrawerScaffoldController drawerScaffoldController =
      DrawerScaffoldController();
  Data db = Data();
  RxInt ind = 0.obs;
  RxList<Map> titles = <Map>[].obs;
  RxList<Map> favorites = <Map>[].obs;
  RxList<int> favs = <int>[].obs;
  List<int> list = [];
  SharedPreferences? sharedPreferences;
  RxDouble fontSize = 20.0.obs;
  RxInt color = 0xff00838f.obs;
  RxString verticalGroupValue = "normal".obs;
  RxString colorFont = "اسود".obs;
  RxString showBtns = "اظهار / واخفاء".obs;

// TODO: Implement _loadInterstitialAd()

  setDefault() {
    fontSize.value = 20.0;
    color.value = 0xff00838f;
    verticalGroupValue.value = "normal";
    colorFont.value = "اسود";
    showBtns.value = "اظهار / واخفاء";
    // loadSettings();
  }

  deleteAllFav() async {
    await db.deleteAllFav();
    readFavorite();
  }

  Future<void> share(title, text, String s) async {
    await FlutterShare.share(
        title: title,
        text: text,
        linkUrl: s,
        chooserTitle: 'Example Chooser Title');
  }

  loadSettings() async {
    fontSize.value = sharedPreferences!.containsKey("fontSize")
        ? sharedPreferences!.getDouble("fontSize")!
        : fontSize.value;
    color.value = sharedPreferences!.containsKey("color")
        ? sharedPreferences!.getInt("color")!
        : color.value;
    verticalGroupValue.value = sharedPreferences!.containsKey("font")
        ? sharedPreferences!.getString("font")!
        : verticalGroupValue.value;
    colorFont.value = sharedPreferences!.containsKey("colorFont")
        ? sharedPreferences!.getString("colorFont")!
        : colorFont.value;
    showBtns.value = sharedPreferences!.containsKey("showBtns")
        ? sharedPreferences!.getString("showBtns")!
        : showBtns.value;
  }

  readTitles() async {
    titles.value = await db.getTitles();
  }

  readFavorite() async {
    list = [];
    favorites.value = await db.getAllFav();
    favorites.forEach((element) {
      list.add(int.parse(element["id"].toString()));
    });
    favs.value = list;
  }

  addFav(id) async {
    await db.ins_fav(id);
    readFavorite();
  }

  delete(id) async {
    await db.deleteFav_bab(id);
    readFavorite();
  }

  deleteF(id) async {
    await db.deleteFav_bab(id);
    // readFavorite();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    db.inti();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    sharedPreferences = await SharedPreferences.getInstance();
    loadSettings();
  }
}
