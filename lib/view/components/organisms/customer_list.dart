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
  const CustomerList.vertical({super.key, required this.customerData,  this.onTapCountCustomer, this.horizontal = false, this.regularData,this.onTap});

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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: regularData!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomerCard(regularData: regularData![index], onTap: onTapCountCustomer!);
                  },
                )))
        : ListBuilder<Customer>(itemDatas: customerData!, listItem: (item) => CustomerInfoCard(customer: item, onTap: onTap!));
  }
}
