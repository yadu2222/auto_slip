import 'package:flutter/material.dart';
import '../../models/regular_model.dart';
import '../atoms/item_card.dart';

class RegularCard extends StatelessWidget {
  const RegularCard({super.key, required this.regular,this.isQuantity = true});

  final Regular regular; // 表示する定期情報
  final bool isQuantity;

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(regular.customer.customerName),
        Text(regular.customer.regularTypeString),
       // TODO:電話番号？
        isQuantity ? Text(regular.quantity.toString()) : const SizedBox.shrink(),
      ],
    ));
  }
}
