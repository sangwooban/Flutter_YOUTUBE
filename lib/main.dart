import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:youtube/src/app.dart';
import 'package:youtube/src/binding/init_binding.dart';
import 'package:youtube/src/components/youtube_detail.dart';
import 'package:youtube/src/controller/youtube_detail_controller.dart';
import 'package:youtube/src/controller/youtube_search_controller.dart';
import 'package:youtube/src/pages/search.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Youtube Clon App",
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Container(),  // Remove For Change Root to app.dart
      initialBinding: InitBinding(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => App()),
        GetPage(
          name: "/detail/:videoId",
          page: () => YoutubeDetail(),
          binding: BindingsBuilder(
            () => Get.lazyPut<YoutubeDatailController>(
                () => YoutubeDatailController()),
          ),
        ),
        GetPage(
          name: "/search",
          page: () => YoutubeSearch(),
          binding: BindingsBuilder(
            () => Get.lazyPut<YoutubeSearchController>(
                () => YoutubeSearchController()),
          ),
        ),
      ],
    );
  }
}
