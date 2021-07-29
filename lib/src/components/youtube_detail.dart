import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube/src/controller/youtube_detail_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetail extends GetView<YoutubeDatailController> {
  const YoutubeDetail({Key key}) : super(key: key);

  Widget _titleZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              //"개발하는 남자 유튜브 영상다시보기"
              controller.title,
              style: TextStyle(fontSize: 15)),
          Row(
            children: [
              Text(
                controller.viewCount,
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              ),
              Text("*"),
              Text(
                controller.publishedTime,
                style: TextStyle(
                    fontSize: 13, color: Colors.black.withOpacity(0.5)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _description_Zone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Text(
        controller.discription,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buttonOne(String iconPath, String text) {
    return Column(
      children: [
        SvgPicture.asset("assets/svg/icons/$iconPath.svg"),
        Text(text)
      ],
    );
  }

  Widget _buttonZone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buttonOne("like", controller.likeCount),
        _buttonOne("dislike", controller.dislikeCount),
        _buttonOne("share", "공유"),
        _buttonOne("save", "저장")
      ],
    );
  }

  Widget get line => Container(
        height: 1,
        color: Colors.black.withOpacity(0.1),
      );

  Widget _onwerZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.5),
            backgroundImage: Image.network(controller.youtuberThumnailUtl)
                //"https://yt3.ggpht.com/ytc/AAUvwniU0ZOGv47lDdGSQ8H004fQgwOAJRlobuCvXwNl=s48-c-k-c0x00ffffff-no-rj")
                .image,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  controller.youtuberName,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "구독자 ${controller.videoController.youtuber.value.statistics.subscriberCount}",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Text(
              "구독",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  Widget _description() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titleZone(),
        line,
        _description_Zone(),
        _buttonZone(),
        SizedBox(height: 20),
        line,
        _onwerZone()
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    //Get.find<YoutubeDatailController>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          YoutubePlayer(
            controller: controller.playerController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  controller.playerController.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () {
                  //log('Settings Tapped!');
                },
              ),
            ],
            // onReady: () {
            //   _isPlayerReady = true;
            // },
            // onEnded: (data) {
            //   _controller
            //       .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
            //   _showSnackBar('Next Video Started!');
            // },
          ),
          Expanded(
            child: _description(),
          )
        ],
      ),
    );
    // return Container(
    //   child: Center(
    //     child: Text(Get.parameters["videoId"]),
    //   ),
    // );
  }
}
