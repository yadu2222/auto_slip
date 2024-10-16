import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/list_builder.dart';
// view
import 'package:flutter_auto_flip/view/components/molecles/customer_card.dart';
import 'package:flutter_auto_flip/view/components/molecles/customer_info_card.dart';
// model

// 顧客定期情報のリスト
class CustomerList extends StatelessWidget {
  // 横スクロール
  const CustomerList.horizontal({
    super.key,
    required this.regularData,
    required this.onTapCountCustomer,
    this.horizontal = true,
    this.customerData,
    this.onTap,
  });
  // 縦スクロール
  const CustomerList.vertical({super.key, required this.customerData, this.onTapCountCustomer, this.horizontal = false, this.regularData, this.onTap});

  final bool horizontal;

  final List<Customer>? customerData;
  final List<CountingCustomer>? regularData; // 表示する定期のリスト
  final void Function(CountingCustomer)? onTapCountCustomer; // タップ時の処理
  final void Function(Customer)? onTap; // タップ時の処理

  @override
  Widget build(BuildContext context) {
    return horizontal
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.92,
            child: MediaQuery.removePadding(
                // これでラップすると余白が削除される
                context: context,
                removeTop: true,
                removeBottom: true,
                child: Wrap(
                  direction: Axis.horizontal, // 水平方向に並べる
                  spacing: 8.0, // 要素の間隔を設定
                  runSpacing: 8.0, // 折り返し時の間隔を設定
                  children: List.generate(
                    regularData!.length,
                    (index) {
                      return CustomerCard(
                        regularData: regularData![index],
                        onTap: onTapCountCustomer!,
                      );
                    },
                  ),
                )))
        : ListBuilder<Customer>(
            itemDatas: customerData!,
            listItem: (item) => InkWell(
                onTap: () {
                  if (onTap != null) {
                    onTap!(item);
                  }
                },
                child: CustomerInfoCard(customer: item)));
  }
}
