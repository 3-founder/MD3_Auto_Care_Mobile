import 'package:get/get.dart';
import 'package:md3_auto_care/controllers/network_controller.dart';

class DepedencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
