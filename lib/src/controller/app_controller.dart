import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube/src/components/youtube_bottom_sheet.dart';

enum RouteName { Home, Explore, Add, Subs, Library }

class AppController extends GetxService {
  // 계속 유지되기 때문에 Service
  static AppController get to => Get.find(); // to find easy. It is tip  ??
  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    if (RouteName.values[index] == RouteName.Add) {
      _showBottomSheet();
    } else {
      currentIndex(index);
    }
  }

  void _showBottomSheet() {
    Get.bottomSheet(YoutubeBottomSheet());
  }
}
