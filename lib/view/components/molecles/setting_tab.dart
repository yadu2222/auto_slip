import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../atoms/item_card.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({
    super.key,
    required this.name,
    required this.movePage,
  });

  final String name;
  final String movePage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.go(movePage);
        },
        child: ItemCard(
            width: 0.2,
            height: 100,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name),
              ],
            )));
  }
}
