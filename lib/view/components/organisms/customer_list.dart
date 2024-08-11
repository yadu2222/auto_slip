import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
// view
import 'package:flutter_auto_flip/view/components/molecles/customer_card.dart';
// model

// 顧客定期情報のリスト
class CustomerList extends StatelessWidget {
  const CustomerList({
    super.key,
    required this.regularData,
    required this.onTap,
  });

  final List<CountingCustomer> regularData; // 表示する定期のリスト
  final void Function(Customer) onTap; // タップ時の処理

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: MediaQuery.removePadding(
            // これでラップすると余白が削除される
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: regularData.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomerCard(regularData: regularData[index], onTap: onTap);
              },
            )));
  }
}
