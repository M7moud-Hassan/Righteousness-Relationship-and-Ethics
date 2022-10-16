import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pro/Controller/MyController.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pro/pages/AboutApp.dart';
import 'package:pro/pages/Favorite.dart';
import 'package:pro/pages/Settings.dart';

class ShowPage extends GetView<MyController> {
  ShowPage(this.index, {Key? key}) : super(key: key) {
    controller.ind.value = index;
    controller.readFavorite();
  }
  final index;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(controller.color.value),
            title: Obx(
                () => Text(controller.titles[controller.ind.value]["title"])),
            actions: [
              Obx(() => IconButton(
                  onPressed: () {
                    controller.favs.contains(int.parse(controller
                            .titles[controller.ind.value]["id"]
                            .toString()))
                        ? controller.delete(
                            controller.titles[controller.ind.value]["id"])
                        : controller.addFav(
                            controller.titles[controller.ind.value]["id"]);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.favs.contains(int.parse(controller
                            .titles[controller.ind.value]["id"]
                            .toString()))
                        ? Colors.red
                        : Colors.white,
                  ))),
              PopupMenuButton<int>(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Get.to(Settings);
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
          body: Stack(
            children: [
              PageView(
                controller: PageController(initialPage: index),
                onPageChanged: (i) {
                  controller.ind.value = i;
                },
                children: List.generate(
                    controller.titles.length,
                    (index) => SingleChildScrollView(
                          child: Html(
                            style: {
                              "body": Style(
                                fontSize: FontSize(controller.fontSize.value),
                                textAlign: TextAlign.center,
                                padding: EdgeInsets.only(
                                    top: 50, right: 10, left: 10, bottom: 10),
                                color: controller.colorFont.value == "اسود"
                                    ? Colors.black
                                    : Colors.grey,
                                fontFamily: controller.verticalGroupValue.value,
                              ),
                              "h4": Style(
                                  fontWeight: FontWeight.w900,
                                  fontSize: FontSize(
                                    controller.fontSize.toInt() + 3,
                                  ),
                                  color: Color(controller.color.value))
                            },
                            data:
                                "<h4>${controller.titles[index]["head"]}</h4></hr><br>"
                                "<p>${controller.titles[index]["body"]}</p>",
                          ),
                        )),
              ),
            ],
          ),
        ));
  }
}
