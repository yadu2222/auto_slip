import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';
import 'package:flutter_auto_flip/view/components/molecles/delivery_card.dart';

// 伝票のリスト
class DeliveryList extends StatelessWidget {
  const DeliveryList({
    super.key,
    required this.deliveries,
  });

  final List<Delivery> deliveries; // 表示する定期のリスト

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        (deliveries.length / 2).ceil(),
        (index) {
          int startIndex = index * 2;
          int endIndex = startIndex + 2;

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DeliveryCard(deliveryData: deliveries[startIndex]),
              if (endIndex < deliveries.length) DeliveryCard(deliveryData: deliveries[endIndex]),
            ],
          );
        },
      ),
    );
  }
}
