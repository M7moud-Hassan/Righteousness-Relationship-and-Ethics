import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:pro/Controller/MyController.dart';
import 'package:pro/pages/AboutApp.dart';
import 'package:pro/pages/Settings.dart';

import 'Favorite.dart';
import 'SecondPage.dart';

class Home extends GetView<MyController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      controller: controller.drawerScaffoldController,
      onOpened: (s){
        controller.drawerOpen.value=!controller.drawerOpen.value;
        controller.drawerOpen.isTrue?controller.animationController!.forward():controller.animationController!.reverse();
      },
      onClosed: (s){
        controller.drawerOpen.value=!controller.drawerOpen.value;
        controller.drawerOpen.isTrue?controller.animationController!.forward():controller.animationController!.reverse();
      },
      body: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/bb.png")
          )
        ),
        child:Row(
          children: [
            IconButton(onPressed: (){
              controller.drawerOpen.value=!controller.drawerOpen.value;
              controller.drawerOpen.isTrue?controller.animationController!.forward():controller.animationController!.reverse();
              controller.drawerOpen.isTrue?controller.drawerScaffoldController.openDrawer(Direction.right):
                  controller.drawerScaffoldController.closeDrawer(Direction.right);
            }, icon: AnimatedIcon(progress: controller.animationController!,icon: AnimatedIcons.menu_arrow,color: Color(controller.color.value),)),
            Expanded(child: Text("")),
            IconButton(onPressed: (){
              Get.to(SecondPage());
            }, icon: Icon(Icons.menu_book,color: Color(controller.color.value))),

          ],
        )) ,
      drawers: [
        SideDrawer(
          percentage:1,
          direction: Direction.right,
         color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            children: [
             ListTile(
               onTap: (){
                 Get.to(SecondPage());
               },
               leading: Icon(Icons.menu,color: Color(controller.color.value),),
               title: Text("البروالصلة والآداب",style: (TextStyle(color: Color(controller.color.value),)),),
             ),
              SizedBox(height: 20,),
              ListTile(
                onTap: (){
                  Get.to(Favorite());
                },
                leading: Icon(Icons.favorite,color: Color(controller.color.value),),
                title: Text("المفضلة",style: TextStyle(color: Color(controller.color.value),),),
              ),
              SizedBox(height: 20,),
              ListTile(
                onTap: (){
                  Get.to(Settings());
                },
                leading: Icon(Icons.settings,color: Color(controller.color.value),),
                title: Text("الاعدادات",style: TextStyle(color: Color(controller.color.value),),),
              ),
              SizedBox(height: 20,),
              ListTile(
                onTap: (){
                  Get.to(AboutApp());
                },
                leading: Icon(Icons.info,color: Color(controller.color.value),),
                title: Text("عن التطبيق",style: TextStyle(color: Color(controller.color.value),),),
              ),
              SizedBox(height: 20,),
              ListTile(
                onTap: (){
                  controller.share("تطبيق البر والصلة ولااب", "مشارمة التطبيق ", "https://play.google.com/store/apps/details?id=apps.soonfu.pro");
                },
                leading: Icon(Icons.share,color: Color(controller.color.value),),
                title: Text("مشاركة التطبيق",style: TextStyle(color: Color(controller.color.value),),),
              ),
              SizedBox(height: 20,),
              ListTile(
                onTap: (){
                  LaunchReview.launch(
                      androidAppId: "apps.soonfu.pro"
                  );
                },
                leading: Icon(Icons.star_rate,color: Color(controller.color.value)),
                title: Text("تقيم التطبيق",style: TextStyle(color: Color(controller.color.value)),),
              ),
              SizedBox(height: 20,),
              ListTile(
                onTap: (){
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                leading: Icon(Icons.exit_to_app,color: Color(controller.color.value)),
                title: Text("خروج",style: TextStyle(color: Color(controller.color.value)),),
              ),
              SizedBox(height: 20,),
            ],
          ),
        )
      ],
    );
  }
}
