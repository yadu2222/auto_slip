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
    required this.magazineTap,
    this.isCustomer = true,
  });

  final bool isCustomer; // どちらを優先して表示するか
  final List<LoadRegular> regularList; // 表示する定期のリスト
  final void Function(Customer) onTap;
  final void Function(Magazine) magazineTap;


  // 顧客優先表示リスト
  @override
  Widget build(BuildContext context) {
    return ListBuilder<LoadRegular>(
        itemDatas: regularList,
        listItem: (item) => Column(children: [
              MagazineCard(
                icon: Icons.add,
                magazine: item.magazine!,
                edit: (magazine) => magazineTap(item.magazine!),
              ),
              SizedBox(height: 120, child: CustomerList.horizontal(regularData: item.regulars, onTap: onTap))
            ]));
  }
}
