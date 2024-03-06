import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// JSON変換関連を行うクラス
class JsonParser {
  // ローカルファイルのjsonを読み込みStringに変換 -> List に変換して戻す
  static Future<List<dynamic>> parseJson(String fileName) async {
    String _loadData = await rootBundle.loadString(fileName);
    return jsonDecode(_loadData);
  }
}
