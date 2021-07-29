import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:youtube/src/controller/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDatailController extends GetxController {
  VideoController videoController;
  YoutubePlayerController playerController;

  @override
  void onInit() {
    //print(Get.parameters["videoId"]);
    videoController = Get.find(tag: Get.parameters["videoId"]);
    playerController = YoutubePlayerController(
      initialVideoId: Get.parameters["videoId"],
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    print(videoController.video.snippet.title);
    super.onInit();
  }

  String get title => videoController.video.snippet.title;
  String get viewCount => "조회수${videoController.statistics.value.viewCount}";
  String get publishedTime =>
      DateFormat("yyy-MM-dd").format(videoController.video.snippet.publishTime);

  String get discription => videoController.video.snippet.description;
  String get likeCount => videoController.statistics.value.likeCount;
  String get dislikeCount => videoController.statistics.value.dislikeCount;

  String get youtuberThumnailUtl => videoController.youtuberThumbnailUrl;

  String get youtuberName => videoController.youtuber.value.snippet.title;
}
