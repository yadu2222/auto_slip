import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/tell_icon.dart';
import '../atoms/item_card.dart';
import 'package:flutter_auto_flip/view/components/atoms/count_icon.dart';

class CustomerInfoCard extends StatelessWidget {
  const CustomerInfoCard({super.key, required this.customer,});

  final Customer customer; // 表示する定期情報


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

  IconData? get tellType {
    switch (customer.tellType) {
      case 1:
        return TellIconType.unnecessary.getIcon(); // 不要
      case 2:
        return TellIconType.essential.getIcon(); // 要
      case 3:
        return TellIconType.call.getIcon(); // 着信のみ
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Icon(countIconType),
          const SizedBox(width: 10),
          Text(customer.customerName),
        ]),
        Row(children: [
          Text(customer.address ?? ""),
          const SizedBox(width: 10),
          // Text(customer.customerAddress),
          Icon(tellType),
        ]),
      ],
    ));
  }
}
