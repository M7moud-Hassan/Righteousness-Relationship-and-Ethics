import 'package:get/get.dart';
import 'package:pro/Controller/MyController.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<MyController>(() => MyController());
  }

}