import 'package:diapp/utils/JsonParser.dart';
import 'data/Diary.dart';

// 日付に基づいた情報を管理するクラス
class DiarysModel {
  List<Diary> _diarysList = [];
  String _jsonFileName = 'assets/json/diary.json';

  DiarysModel() {
    parseJson();
  }

  // ローカルjsonファイル を Listで取得する
  parseJson() {
    JsonParser.parseJson(_jsonFileName).then((value) {
      value.forEach((element) {
        _diarysList.add(Diary.parseJson(element));
      });
      print("complete");
    });
  }

  // 指定した日付の情報を取得する
  Diary getDiary(String date) {
    return _diarysList.firstWhere((Diary? element) {
      return element?.dateTime == date;
    }, orElse: Diary.empty);
  }
}
