import 'package:flutter/material.dart';

import '../service/test_service.dart';
// import 'package:go_router/go_router.dart';

// import '../../view/components/atoms/toast.dart';
// import '../../../constant/messages.dart';

class TestReq {
  final BuildContext context;
  TestReq({required this.context});

  // 接続テスト
  Future<void> connectTestHandler() async {
    try {
      await TestService.connectTest(); // ログイン処理を待つ
      // // ログイン完了後の処理
      // GoRouter.of(context).go('/home');
      debugPrint("接続に成功しました"); // 登録成功メッセージ
    } catch (error) {
      debugPrint(error.toString());
      debugPrint( "接続に失敗しました"); // 登録失敗メッセージ
    }
  }
}
