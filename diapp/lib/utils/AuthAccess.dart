import 'package:firebase_auth/firebase_auth.dart';

// アカウント認証を行うクラス
class AuthAccess {

  static final AuthAccess _instance = AuthAccess._internal();

  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  factory AuthAccess() {
    return _instance;
  }

  AuthAccess._internal() {}

  Future signIn(String id, String pass) async {
    try {
      print("signIn: start");
       await _authInstance.signInWithEmailAndPassword(
        email: id,
        password: pass,
      );
      print("signIn: SUCCESS");
    }
    on FirebaseAuthException catch (e) {
      print("signIn: ERROR");
      print("エラーコード: ${ e.code }");
    }
  }
}