import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/view/components/molecles/counting_card.dart';
import 'package:flutter_auto_flip/view/components/organisms/customer_list.dart';
// view
import '../atoms/list_builder.dart';

// model
import '../../../models/customer_model.dart';

// 雑誌をカウントして表示
class CountingList extends StatelessWidget {
  const CountingList({
    super.key,
    required this.loadData,
    required this.onTapCutomer,
    required this.onTapCounting,
    required this.isCustomer,
  });

  final List<Counting> loadData; // 表示する定期のリスト
  final void Function(Customer) onTapCutomer; // タップ時の処理
  final void Function(Counting) onTapCounting; // タップ時の処理
  final bool isCustomer; // どちらを優先して表示するか

  @override
  Widget build(BuildContext context) {
    return ListBuilder<Counting>(
      itemDatas: loadData,
      listItem: (item) => Column(children: [
        // アイコンの説明
        CountingCard(countData: item, onTap: onTapCounting), // 雑誌情報を表示するカード

        // 顧客情報を表示
        isCustomer ? SizedBox(height: 100, child: CustomerList(regularData: item.countingCustomers, onTap: onTapCutomer)) : const SizedBox.shrink()
      ]),
    );
  }
}
