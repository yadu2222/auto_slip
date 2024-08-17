import 'package:flutter/material.dart';

import '../../models/customer_model.dart';
import '../service/customer_service.dart';
// import 'package:go_router/go_router.dart';
import '../../../constant/messages.dart';

class CustomerReq {
  final BuildContext context;
  CustomerReq({required this.context});

  // お客様情報の取得ハンドラー
  Future<List<Customer>> getCustomerHandler() async {
    try {
      List<Customer> result = await CustomerService.getCustomer(); // 取得処理を待つ
      // ログイン完了後の処理
      // GoRouter.of(context).go('/home');
      debugPrint( Messages.getCustomerSuccess); // 取得成功メッセージ
      return result;
    } catch (error) {
      debugPrint(Messages.getCustomerError); // 取得失敗メッセージ
      return [];
    }
  }

  // 名前で検索
  Future<List<Customer>> searchCustomerNameHandler(String customerName) async {
    try {
      List<Customer> result = await CustomerService.searchCustomerName(customerName); // 取得処理を待つ
      return result;
    } catch (error) {
      debugPrint("取得に失敗しました"); // 取得失敗メッセージ
      return [];
    }
  }

  // 顧客登録ハンドラー
  Future<void> addCustomerHandler(Customer customer) async {
    try {
      await CustomerService.addCustomer(customer); // 登録処理を待つ
      debugPrint("せいこう"); // 登録成功メッセージ
    } catch (error) {
      debugPrint("しっぱい"); // 登録失敗メッセージ
    }
  }

  
}
