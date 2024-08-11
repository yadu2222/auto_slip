import 'package:flutter/material.dart';
// import 'package:flutter_auto_flip/constant/colors.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/models/regular_model.dart';
import '../atoms/item_card.dart';

// 雑誌情報を表示するカード
class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.regularData,
    this.isRed = false,
    required this.onTap,
  });

  final Map<String, dynamic> regularData;
  final bool isRed; // 赤文字表示
  final void Function(Customer) onTap; // タップ時の処理

  @override
  Widget build(BuildContext context) {
    final Customer customer = regularData['customer'] as Customer;
    final Regular regular = regularData['regular'] as Regular;

    return ItemCard(
        width: 0.15,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(customer.customerName),
            Text(customer.address ?? ''),
            Text(regular.quantity.toString()),
          ],
        ));
  }
}
