import 'package:diapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Firebase関連のライブラリをクラス
class FirebaseSettings {

  static final FirebaseSettings _instance = FirebaseSettings._internal();

  factory FirebaseSettings() {
    return _instance;
  }

  FirebaseSettings._internal() {}

  Future<void> init() async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      print(e);
    }
  }
}