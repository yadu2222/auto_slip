import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/constant/colors.dart';
import 'package:flutter_auto_flip/constant/fonts.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_auto_flip/constant/colors.dart';

// 納品書を表示するカード
class DeliveryCard extends StatelessWidget {
  const DeliveryCard({
    super.key,
    required this.deliveryDate,
    required this.deliveryData,
    this.isRed = false,
    required this.onTapDelite,
  });

  final void Function(Delivery) onTapDelite; // タップ時の処理
  final DateTime deliveryDate;
  final Delivery deliveryData;
  final bool isRed; // 赤文字表示

  // カンマを入れるメソッド
  String formatNumberWithComma(num number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    // セルにパディングを設定
    Widget buildTableCell(String text, {bool isLeft = false}) {
      return Container(
        alignment: isLeft ? Alignment.centerLeft : Alignment.center,
        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
        child: Text(text, textAlign: TextAlign.center),
      );
    }

    return InkWell(
        onTap: () => onTapDelite(deliveryData),
        child: Container(
          width: 450,
          height: 240,
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(border: Border.all(color: AppColors.font)),
          child: Column(
            children: [
              const Text(
                '納品書',
                style: Fonts.h5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  '${deliveryData.storeName} 様',
                  style: Fonts.h5,
                ),
                const Text(
                  '松田書店',
                  style: Fonts.p,
                ),
              ]),
              const SizedBox(height: 3),
              Table(
                border: TableBorder.all(color: AppColors.font),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(200),
                  1: FixedColumnWidth(50),
                  2: FixedColumnWidth(50),
                  3: FixedColumnWidth(50),
                  4: FixedColumnWidth(60),
                },
                children: [
                  TableRow(children: [
                    buildTableCell('誌名'),
                    buildTableCell('号数'),
                    buildTableCell('数量'),
                    buildTableCell('単価'),
                    buildTableCell('価格'),
                  ]),
                  for (var magazine in deliveryData.magazines)
                    TableRow(children: [
                      buildTableCell(magazine.magazineName, isLeft: true),
                      buildTableCell(magazine.magazineNumber),
                      buildTableCell(magazine.quantity.toString()),
                      magazine.quantity == 1 ? buildTableCell('') : buildTableCell(formatNumberWithComma(magazine.unitPrice)),
                      buildTableCell(formatNumberWithComma(magazine.quantity * magazine.unitPrice)),
                    ]),
                  // データが5行未満の場合に空行を追加
                  if (deliveryData.magazines.length < 5)
                    for (var i = 0; i < 5 - deliveryData.magazines.length; i++)
                      TableRow(children: [
                        buildTableCell(''),
                        buildTableCell(''),
                        buildTableCell(''),
                        buildTableCell(''),
                        buildTableCell(''),
                      ]),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('${deliveryDate.year}/${deliveryDate.month}/${deliveryDate.day}'),
              ]),
            ],
          ),
        ));
  }
}
