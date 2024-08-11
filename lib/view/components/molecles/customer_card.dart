import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
// import 'package:flutter_auto_flip/constant/colors.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import '../atoms/item_card.dart';

// お客様情報を表示するカード
class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.regularData,
    this.isRed = false,
    required this.onTap,
  });

  final CountingCustomer regularData;
  final bool isRed; // 赤文字表示
  final void Function(Customer) onTap; // タップ時の処理

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        width: 0.15,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(regularData.customer.customerName),
            // Text(regularData.customer.address ?? ''),
            Text(regularData.regular.quantity.toString()),
          ],
        ));
  }
}
