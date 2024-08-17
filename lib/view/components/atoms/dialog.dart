import 'package:flutter/material.dart';

// カスタマイズしたいなあというきもち
class DialogUtil {
  static void show({required BuildContext context, required Widget child, bool isBarrier = false}) {
    showDialog(
        context: context,
        barrierDismissible: isBarrier,
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 0.0, // ダイアログの影を削除
              backgroundColor: Colors.transparent, // 背景色
              content: child);
        });
  }
}
