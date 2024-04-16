import 'dart:ffi';

import 'package:diapp/utils/AuthAccess.dart';
import 'package:diapp/utils/DialogBuilder.dart';
import 'package:diapp/utils/FirebaseSettings.dart';
import 'package:diapp/view/TabWidget.dart';
import 'package:flutter/material.dart';

class BeforeLoginPage extends StatefulWidget {
  const BeforeLoginPage({super.key});

  @override
  State<BeforeLoginPage> createState() => _BeforeLoginState();
}

class _BeforeLoginState extends State<BeforeLoginPage> {

  var _inputUserId = "";
  var _inputPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("設定"),
        ),
        body: Column(
            children: <Widget>[
                Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                            width: 30,
                            height: 30,
                            child: Icon(Icons.account_circle)
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "ログイン画面",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "User ID",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              userIdTextField(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              passwordTextField(),
              InkWell(
                onTap: () async {
                  var errorCode = await confirmLogin();

                  if (errorCode == null) {
                    // 画面遷移
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabPage()));
                  } else {
                    DialogBuilder().showSingleDialog(context, "エラー", "ログインできませんでした\n(" + errorCode + ")");
                  }
                },
                child:
                Container(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "ログイン",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              )
            ]
        ));
  }

  TextField userIdTextField() {
    return TextField(
        decoration: InputDecoration(
          hintText: 'User ID',
        ),
        onChanged: (text) {
          _inputUserId = text;
        }
    );
  }

    TextField passwordTextField() {
      return TextField(
          decoration: InputDecoration(
            hintText: 'password',
          ),
          onChanged: (text) {
            _inputPassword = text;
          }
      );
  }

  // ログイン実施
  Future<String?> confirmLogin() async {
    try {
      AuthAccess auth = AuthAccess();
      return await auth.signIn(_inputUserId, _inputPassword);
    } catch (e) {
      return e.toString();
    }
  }

}
