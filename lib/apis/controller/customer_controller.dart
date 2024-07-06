import 'package:flutter/material.dart';

import '../../models/customer_model.dart';
import '../service/customer_service.dart';
import 'package:go_router/go_router.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';

class CustomerReq {
  final BuildContext context;
  CustomerReq({required this.context});

  // お客様情報の取得ハンドラー
  Future<void> getCustomerHandler(Map<String, dynamic> registerUser) async {
    try {
      await CustomerService.getCustomer(registerUser); // ログイン処理を待つ
      // ログイン完了後の処理
      GoRouter.of(context).go('/home');
      ToastUtil.show(message: Messages.getCustomerSuccess); // 登録成功メッセージ
    } catch (error) {
      ToastUtil.show(message: Messages.getCustomerError); // 登録失敗メッセージ
    }
  }
}
