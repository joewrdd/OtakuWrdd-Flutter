import 'package:get/get.dart';

class NotificationsMenuTileController extends GetxController {
  static NotificationsMenuTileController get instance => Get.find();
  final RxBool isChecked = false.obs;
  final RxBool isIcon = false.obs;
}
