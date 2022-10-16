import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pro/pages/AboutApp.dart';
import 'package:pro/pages/Favorite.dart';
import 'package:pro/pages/Settings.dart';

import '../Controller/MyController.dart';
import 'Player.dart';
import 'Show_Page.dart';

class SecondPage extends GetView<MyController> {
  SecondPage({Key? key}) : super(key: key) {
    controller.readTitles();
    controller.readFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(controller.color.value),
            title: Text("قائمتي"),
            actions: [
              PopupMenuButton<int>(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Get.to(Settings());
                            },
                            leading: Icon(Icons.settings),
                            title: Text(
                              "الاعدادات",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Get.to(Favorite());
                            },
                            leading: Icon(Icons.favorite),
                            title: Text(
                              "المفضبة",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Get.to(AboutApp());
                            },
                            leading: Icon(Icons.info),
                            title: Text(
                              "عن التطبيق",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            leading: Icon(Icons.exit_to_app),
                            title: Text(
                              "خروج",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      ])
            ],
          ),
          body: Obx(() => ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Get.to(ShowPage(index));
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Obx(() => IconButton(
                          onPressed: () {
                            controller.favs.contains(int.parse(
                                    controller.titles[index]["id"].toString()))
                                ? controller
                                    .delete(controller.titles[index]["id"])
                                : controller
                                    .addFav(controller.titles[index]["id"]);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: controller.favs.contains(int.parse(
                                    controller.titles[index]["id"].toString()))
                                ? Colors.red
                                : Color(controller.color.value),
                          ),
                        )),
                    title: Text(controller.titles[index]["title"]),
                    trailing: IconButton(
                      onPressed: () {
                        Get.to(Player(
                          index: index,
                          color: Color(controller.color.value),
                        ));
                      },
                      icon: Icon(
                        Icons.music_note,
                        color: Color(controller.color.value),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    height: 0,
                  ),
              itemCount: controller.titles.length)),
        ));
  }
}
