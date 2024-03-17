
// 日付に基づいた情報
class Diary {
  String? dateTime;
  String? memo;

  Diary({required this.dateTime, required this.memo });

  Diary.empty() {
    dateTime = "empty";
    memo = "";
  }

  Diary.parseJson(Map<String, dynamic> data) {
    dateTime = data['dateTime'];
    memo = data['memo'];
  }
}