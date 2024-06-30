import 'package:flutter/material.dart';
import '../../models/regular_model.dart';
import '../atoms/item_card.dart';

class RegularCard extends StatelessWidget {
  const RegularCard({super.key, required this.regular});

  final Regular regular; // 表示する定期情報

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(regular.customerName),
        Text(regular.regularTypeString),
        Text(regular.quantity.toString()),
      ],
    ));
  }
}
