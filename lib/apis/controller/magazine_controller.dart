import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constant/messages.dart';

// view
// import '../../view/components/atoms/toast.dart';
// model
import '../../models/magazine_model.dart';
// service
import '../service/magazine_service.dart';
import 'dart:io';

class MagazineReq {
  final BuildContext context;
  MagazineReq({required this.context});

  // csvで雑誌情報登録
  Future<void> registeforCSVMagazineHandler(List<File> files) async {
    try {
      debugPrint("kitya");
      await MagazineService.registerForCSVMagazines(files); // 取得処理を待つ
      // ログイン完了後の処理
      // GoRouter.of(context).go('/home');
      debugPrint("せいこう"); // 取得成功メッセージ
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
    }
  }

  // 雑誌情報取得
  Future<List<Magazine>> getMagazineHandler() async {
    try {
      final magazines = await MagazineService.getMagazines(); // 取得処理を待つ
      return magazines;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("取得に失敗しました"); // 取得失敗メッセージ
      return [];
    }
  }

  // 雑誌コードで検索
  Future<List<Magazine>> searchMagazineCodeHandler(String magazineCode) async {
    try {
      final magazines = await MagazineService.searchMagazineCode(magazineCode); // 取得処理を待つ
      return magazines != null ? [magazines] : [];
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("取得に失敗しました"); // 取得失敗メッセージ
      return [];
    }
  }

  // 雑誌名で検索
  Future<List<Magazine>> searchMagazineNameHandler(String magazineName) async {
    try {
      final magazines = await MagazineService.searchMagazineName(magazineName); // 取得処理を待つ
      return magazines;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("取得に失敗しました"); // 取得失敗メッセージ
      return [];
    }
  }
}
