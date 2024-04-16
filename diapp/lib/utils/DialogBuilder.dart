import 'package:flutter/material.dart';

class DialogBuilder {

  static final DialogBuilder _instance = DialogBuilder._internal();

  factory DialogBuilder() {
    return _instance;
  }

  DialogBuilder._internal() {}

  void showSingleDialog(BuildContext context,String title, String message) {
    showDialog(context: context, builder: (_) {
      return _alertSingleBuilder(context, title, message);
    });
  }

  AlertDialog _alertSingleBuilder(BuildContext context, String title, String message) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'))
      ],);
  }
}

