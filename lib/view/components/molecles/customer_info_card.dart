import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import '../atoms/item_card.dart';
import 'package:flutter_auto_flip/view/components/atoms/count_icon.dart';

class CustomerInfoCard extends StatelessWidget {
  const CustomerInfoCard({super.key, required this.customer, required this.onTap});

  final Customer customer; // 表示する定期情報
  final void Function(Customer) onTap;

  IconData get countIconType {
    switch (customer.regularType) {
      case 1:
        return CountIconType.delivery.getIcon();
      case 2:
        return CountIconType.store.getIcon();
      case 3:
        return CountIconType.slip.getIcon();
      case 4:
        return CountIconType.library.getIcon();
      case 5:
        return CountIconType.delivery.getIcon();
      case 6:
        return CountIconType.marucho.getIcon();
      case 7:
        return CountIconType.library.getIcon();
      default:
        return CountIconType.store.getIcon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      children: [
        Icon(countIconType),
        const SizedBox(width: 10),
        Text(customer.customerName),
      ],
    ));
  }
}
