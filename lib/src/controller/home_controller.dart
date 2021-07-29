import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube/src/models/youtube_video_result.dart';
import 'package:youtube/src/repository/youtube_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    _videoLoad();
    _event();
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      //print(scrollController.position.pixels);
      //print(scrollController.position.maxScrollExtent);
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPagetoken != "") {
        _videoLoad();
        print("reload");
      }
    });
  }

  void _videoLoad() async {
    print(youtubeResult.value.nextPagetoken);

    YoutubeVideoResult youtubeVideoResult = await YoutubeRepository.to
        .loadVideos(youtubeResult.value.nextPagetoken ?? "");
    //print(youtubeVideoResult.items.length);

    // if (youtubeVideoResult != null &&
    //     youtubeVideoResult.items != null &&
    //     youtubeVideoResult.items.length > 0) {
    //   youtubeResult(youtubeVideoResult);
    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult.update((youtube) {
        youtube.nextPagetoken = youtubeVideoResult.nextPagetoken;
        youtube.items.addAll(youtubeVideoResult.items);
      });
    }
  }
}
