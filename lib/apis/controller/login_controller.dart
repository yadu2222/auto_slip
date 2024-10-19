import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/service/login_service.dart';

class LoginReq {
  final BuildContext context;
  LoginReq({required this.context});

  // csvで数取り
  Future<String> loginHandler(String userId,String password) async {
    try {
      String token = await LoginService.login(userId,password); // 取得処理を待つ
      return token;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return "";
    }
  }
}
