import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/src/components/customappbar.dart';
import 'package:youtube/src/components/video_widget.dart';
import 'package:youtube/src/controller/home_controller.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    //AS-IS
    /*return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("Home"),
        ));
    */
    return SafeArea(
      child: Obx(
        () => CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              //AS-IS
              /*title: Container(
              child: Text("AppBar"),
            ),*/
              title: CustomAppBar(),
              floating: true,
              snap: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return GestureDetector(
                  onTap: () {
                    //page route
                    //Get.toNamed("/detail/239587");
                    Get.toNamed(
                        "/detail/${controller.youtubeResult.value.items[index].id.videoId}");
                  },
                  child: VideoWidget(
                      video: controller.youtubeResult.value.items[index]),
                );
                /*return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  color: Colors.grey,
                ),
              );*/
              },
                  childCount: controller.youtubeResult.value.items == null
                      ? 0
                      : controller.youtubeResult.value.items.length),
            ),
          ],
        ),
      ),
    );
  }
}
