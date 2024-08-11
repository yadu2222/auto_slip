import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/view/components/molecles/magazine_card.dart';
import 'package:flutter_auto_flip/view/components/organisms/customer_list.dart';
// view
import '../atoms/list_builder.dart';
// model
import '../../../models/magazine_model.dart';
import '../../../models/load_regular_model.dart';

class RegularList extends StatelessWidget {
  const RegularList({
    super.key,
    required this.regularList,
    required this.onTap,
    this.isCustomer = true,
  });

  final bool isCustomer; // どちらを優先して表示するか
  final List<LoadRegular> regularList; // 表示する定期のリスト
  final void Function(Customer) onTap;

  // 顧客優先表示リスト
  @override
  Widget build(BuildContext context) {
    return ListBuilder<LoadRegular>(
        itemDatas: regularList,
        listItem: (item) => Column(children: [
              MagazineCard(
                magazine: item.magazine!,
                // TODO: ここでタップ時の処理を記述
                onTap: (Magazine magazine) {},
              ),
              SizedBox(height: 150, child: CustomerList(regularData: item.regulars, onTap: onTap))
            ]));
  }
}
