import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';

import 'package:flutter_auto_flip/view/components/atoms/count_icon.dart';
import 'package:flutter_auto_flip/view/components/atoms/magazine_card.dart';

// view
import '../atoms/list_builder.dart';
// model

import '../../../models/load_regular_model.dart';

class RegularCustomerList extends StatelessWidget {
  const RegularCustomerList({
    super.key,
    required this.regularList,
    required this.onTap,
    this.isCustomer = true,
  });

  final bool isCustomer; // どちらを優先して表示するか
  final List<LoadRegular> regularList; // 表示する定期のリスト
  final void Function(CountingCustomer) onTap;

  IconData getCountIconType(int value) {
    switch (value) {
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

  // 顧客を左に寄せたリスト
  @override
  Widget build(BuildContext context) {
    return ListBuilder<LoadRegular>(
        itemDatas: regularList,
        listItem: (item) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SizedBox(
                  child: Row(children: [
                Icon(getCountIconType(item.customer!.regularType)),
                const SizedBox(
                  width: 10,
                ),
                Text(item.customer!.customerName)
              ])),
              SizedBox(
                child: Column(
                  children: item.regular!.map((regularItem) {
                    return InkWell(
                      onTap: () => onTap(CountingCustomer(customer: item.customer!, regular: regularItem.regular)),
                      child: MagazineCard(magazine: regularItem));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ]));
  }
}
