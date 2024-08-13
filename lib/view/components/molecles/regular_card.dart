import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import '../atoms/item_card.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customer, });

  final Customer customer; // 表示する定期情報


  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(customer.customerName),
        
      ],
    ));
  }
}
