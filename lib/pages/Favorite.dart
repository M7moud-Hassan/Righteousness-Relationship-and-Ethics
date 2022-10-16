import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pro/Controller/MyController.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pro/pages/AboutApp.dart';
import 'package:pro/pages/Player.dart';
import 'package:pro/pages/SecondPage.dart';
import 'package:pro/pages/Settings.dart';

import 'Show_Page.dart';

class Favorite extends GetView<MyController> {
  Favorite({Key? key}) : super(key: key) {
    controller.readFavorite();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(controller.color.value),
            title: Text("المفضلة"),
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
              itemBuilder: (context, index) => Obx(() => Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {
                        controller.deleteF(controller.favorites[index]["id"]);
                      }),

                      // All actions are defined in the children parameter.
                      children: const [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          flex: 2,
                          onPressed: null,
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'مسح من المفضلة',
                        ),
                      ],
                    ),

                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: (context) {
                            Get.to(Player(
                              index:
                                  controller.favorites[index]["id"].toInt() - 1,
                            ));
                          },
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Color(controller.color.value),
                          icon: Icons.music_note,
                          label: 'تشغيل الملف الصوتي',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: ListTile(
                        onTap: () {
                          Get.to(ShowPage(
                              controller.favorites[index]["id"].toInt() - 1));
                        },
                        title: Text(controller.favorites[index]["title"])),
                  )),
              separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    height: 0,
                  ),
              itemCount: controller.favorites.length)),
        ));
  }
}
