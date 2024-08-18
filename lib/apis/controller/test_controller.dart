import 'dart:io';

import 'package:flutter/material.dart';

import '../service/test_service.dart';
// import 'package:go_router/go_router.dart';

// import '../../view/components/atoms/toast.dart';
// import '../../../constant/messages.dart';

class TestReq {
  final BuildContext context;
  TestReq({required this.context});

  // 接続テスト
  static Future<void> connectTestHandler() async {
    try {
      await TestService.connectTest(); // ログイン処理を待つ
      // // ログイン完了後の処理
      // GoRouter.of(context).go('/home');
      debugPrint("接続に成功しました"); // 登録成功メッセージ
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("接続に失敗しました"); // 登録失敗メッセージ
    }
  }

  // csvで情報登録
  Future<void> csvRegisterHandler(File file, int type) async {
    try {
      switch (type) {
        case 1:
          {
            await TestService.csvCustomer(file); // 取得処理を待つ
            return;
          }
        case 2:
          {
            await TestService.csvMagazine(file); // 取得処理を待つ
            return;
          }
        case 3:
          {
            await TestService.csvRegular(file); // 取得処理を待つ
            return;
          }
      }
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return;
    }
  }
}
