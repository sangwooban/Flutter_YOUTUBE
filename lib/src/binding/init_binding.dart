import 'dart:ffi';

import 'package:get/get.dart';
import 'package:youtube/src/controller/app_controller.dart';
import 'package:youtube/src/repository/youtube_repository.dart';

class InitBinding implements Bindings {
  @override
  Void dependencies() {
    Get.put(YoutubeRepository(), permanent: true);
    Get.put(AppController());
  }
}
