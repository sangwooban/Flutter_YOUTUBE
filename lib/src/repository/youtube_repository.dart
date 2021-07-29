import 'dart:io';

import 'package:get/get.dart';
import 'package:youtube/src/models/statistics.dart';
import 'package:youtube/src/models/youtube_video_result.dart';
import 'package:youtube/src/models/youtuber.dart';

class YoutubeRepository extends GetConnect {
  // GetConnect -> Include Http
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = "https://www.googleapis.com";
    super.onInit();
  }

  Future<YoutubeVideoResult> loadVideos(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&channelId=UCbMGBIayK26L4VaFrs5jyBw&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&pageToken=$nextPageToken";
    final response = await get(url);

    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
      //print(response.body["items"]);
    }
  }

  Future<YoutubeVideoResult> search(
      String searchKeyword, String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&pageToken=$nextPageToken&q=$searchKeyword";
    final response = await get(url);

    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
      //print(response.body["items"]);
    }
  }

  Future<Statistics> getVideoInfoById(String videoId) async {
    String url =
        "/youtube/v3/videos?part=statistics&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&id=$videoId";
    final response = await get(url);

    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Statistics.fromJson(data["statistics"]);
      }
      //print(response.body["items"]);
    }
  }

  Future<Youtuber> getYoutuberInfoById(String channelID) async {
    String url =
        "/youtube/v3/channels?part=statistics,snippet&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&id=$channelID";
    final response = await get(url);

    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Youtuber.fromJson(data);
      }
      //print(response.body["items"]);
    }
  }
}
