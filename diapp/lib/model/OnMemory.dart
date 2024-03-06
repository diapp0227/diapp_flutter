
import 'DiarysModel.dart';
import 'data/Diary.dart';

// アプリ内に保持している情報を管理するクラス
class OnMemory {

  DiarysModel _diaryModel = new DiarysModel();

  static final OnMemory _instance = OnMemory._internal();

  factory OnMemory() {
    return _instance;
  }

  OnMemory._internal() {}

  Future<Diary> getDiary(String date) async {
    print(date);
    return _diaryModel.getDiary(date);
  }
}