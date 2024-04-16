import 'package:diapp/utils/AuthAccess.dart';
import 'package:diapp/utils/FirebaseSettings.dart';
import 'package:diapp/view/BeforeLoginWidget.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("設定"),
        ),
        body: Column(
            children: <Widget>[
              InkWell(
                onTap: () async {
                  await AuthAccess().signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BeforeLoginPage()));
                },// User Registration
                child:
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
                            "ログアウト",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ]
        ));
  }
}
