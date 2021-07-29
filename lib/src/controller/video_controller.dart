import 'package:get/get.dart';
import 'package:youtube/src/models/statistics.dart';
import 'package:youtube/src/models/video.dart';
import 'package:youtube/src/models/youtuber.dart';
import 'package:youtube/src/repository/youtube_repository.dart';

class VideoController extends GetxController {
  Video video;
  VideoController({this.video});
  Rx<Statistics> statistics = Statistics().obs;
  Rx<Youtuber> youtuber = Youtuber().obs;

  @override
  void onInit() async {
    Statistics loadStatistics =
        await YoutubeRepository.to.getVideoInfoById(video.id.videoId);
    statistics(loadStatistics); // insert
    Youtuber loadYoutuber =
        await YoutubeRepository.to.getYoutuberInfoById(video.snippet.channelId);
    youtuber(loadYoutuber);
    super.onInit();
  }

  String get viewCountString => "조회수 ${statistics.value.viewCount ?? '-'}회";
  String get youtuberThumbnailUrl {
    if (youtuber.value.snippet == null)
      return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfgJ0SYGF5qAueA_nbIYvUB58DCZ2KG-DkYA&usqp=CAU";
    return youtuber.value.snippet.thumbnails.medium.url;
  }
}
