import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/constant/colors.dart';
import 'package:flutter_auto_flip/constant/fonts.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';
// import 'package:flutter_auto_flip/constant/colors.dart';

// お客様情報を表示するカード
class DeliveryCard extends StatelessWidget {
  const DeliveryCard({
    super.key,
    required this.deliveryData,
    this.isRed = false,
  });

  final Delivery deliveryData;
  final bool isRed; // 赤文字表示

  @override
  Widget build(BuildContext context) {
    // セルにパディングを設定
    Widget buildTableCell(String text) {
      return Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
        child: Text(text, textAlign: TextAlign.center),
      );
    }

    return Container(
      width: 450,
      height: 200,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(border: Border.all(color: AppColors.font)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              '${deliveryData.storeName} 様',
              style: Fonts.h5,
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
                  buildTableCell(magazine.magazineName),
                  buildTableCell(magazine.magazineNumber),
                  buildTableCell(magazine.quantity.toString()),
                  magazine.quantity == 1 ? buildTableCell('') : buildTableCell(magazine.unitPrice.toString()),
                  buildTableCell((magazine.quantity * magazine.unitPrice).toString()),
                ])
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(deliveryData.date),
          ]),
        ],
      ),
    );
  }
}
