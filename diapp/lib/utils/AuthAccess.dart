import 'package:firebase_auth/firebase_auth.dart';

// アカウント認証を行うクラス
class AuthAccess {

  static final AuthAccess _instance = AuthAccess._internal();

  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  factory AuthAccess() {
    return _instance;
  }

  AuthAccess._internal() {}

  // サインイン処理
  // 引数のID・passwordに対してログイン処理を実施
  // 戻り値 正常の場合はnull ・異常の場合はエラーコード文字列を返す
  Future<String?> signIn(String id, String pass) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
        email: id,
        password: pass,
      );
      return null;
    }
    on FirebaseAuthException catch (e) {
      print("signIn エラーコード: ${ e.code }");
      return e.code;
    }
  }

  // サインアウト処理
  // 戻り値 正常の場合はnull ・異常の場合はエラーコード文字列を返す
  Future signOut() async {
    try {
      return await _authInstance.signOut();
    }
    on FirebaseAuthException catch (e) {
      print("signOut エラーコード: ${ e.code }");
      return e.code;
    }
  }
}