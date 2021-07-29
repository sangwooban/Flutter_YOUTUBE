import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube/src/models/youtube_video_result.dart';
import 'package:youtube/src/repository/youtube_repository.dart';

class YoutubeSearchController extends GetxController {
  String key = "SearchKey";
  RxList<String> history = RxList<String>.empty(growable: true);
  //RxList<String> history = [""].obs;
  Set<String> originHistory = {};
  SharedPreferences profs;

  Rx<YoutubeVideoResult> youtubeVideoResult = YoutubeVideoResult(items: []).obs;

  @override
  void onInit() async {
    profs = await SharedPreferences.getInstance();
    //String value = (profs.get("testString") as String);
    List<dynamic> initData = profs.get(key) ?? [];
    //profs.setString("testString", "개발하는남자");
    //profs.setStringList("testString", ["개발하는남자"]);
    //print(value);

    //originHistory.addAll(initData.map((_) => _.toString()).toList());
    //history(originHistory.toList());

    history(initData.map((_) => _.toString()).toList());

    super.onInit();
  }

  void search(String search) {
    //history.clear();
    //originHistory.add(search);
    //history.addAll(originHistory.toList());

    history.addIf(!history.contains(search), search);

    profs.setStringList(key, history);
    _searchYoutube(search);
  }

  void _searchYoutube(String search) async {
    YoutubeVideoResult youtubeVideoResultFromServer =
        await YoutubeRepository.to.search(search, "");
    print(youtubeVideoResultFromServer.items.length);

    youtubeVideoResult(youtubeVideoResultFromServer);
  }
}
