import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/models/load_regular_model.dart';

// view
// import '../../view/components/atoms/toast.dart';
// model

// service
import '../service/regular_service.dart';

class RegularReq {
  final BuildContext context;
  RegularReq({required this.context});

  // 定期情報を取得
  Future<List<LoadRegular>> getMagazineRegularHandler() async {
    try {
      List<LoadRegular> result = await RegularService.getMagazineRegular(); // 取得処理を待つ

      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }

  // 顧客名で定期情報を取得
  Future<List<LoadRegular>> getMagazineRegularByCustomerNameHandler(String customerName) async {
    try {
      List<LoadRegular> result = await RegularService.getMagazineRegularByCustomerName(customerName); // 取得処理を待つ
      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }

  // 雑誌名で定期情報を取得
  Future<List<LoadRegular>> getMagazineRegularByMagazineNameHandler(String magazineName) async {
    try {
      List<LoadRegular> result = await RegularService.getMagazineRegularByMagazineName(magazineName); // 取得処理を待つ
      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }

  // 雑誌コードで定期情報を取得
  Future<List<LoadRegular>> getMagazineRegularByMagazineCodeHandler(String magazineCode) async {
    try {
      List<LoadRegular> result = await RegularService.getMagazineRegularByMagazineCode(magazineCode); // 取得処理を待つ
      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }

  // csvで数取り
  Future<List<Counting>> getRegularHandler(File file) async {
    try {
      List<Counting> result = await RegularService.countingRegular(file); // 取得処理を待つ
      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }

  // 定期情報を登録
  Future<void> registerRegularHandler(String magazineCode, String customerUUID, String count) async {
    try {
      await RegularService.registerRegular(magazineCode, customerUUID, count); // 取得処理を待つ
      return;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return;
    }
  }

  // 定期情報を削除
  Future<void> deleteRegularHandler(String regularUUID) async {
    try {
      await RegularService.deleteRegular(regularUUID); // 取得処理を待つ
      return;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return;
    }
  }
}
