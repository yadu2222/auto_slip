
import 'package:flutter/material.dart';

// カスタマイズしたいなあというきもち
class DialogUtil  {
  static void show({
    String title = '完了',
    required String message,
    required BuildContext context
  }) { showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              // dialogの角丸
              borderRadius: BorderRadius.circular(1.0),
            ),
            title:  Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
