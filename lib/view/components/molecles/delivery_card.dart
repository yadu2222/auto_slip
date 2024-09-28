import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/common/number_format.dart';
import 'package:flutter_auto_flip/constant/colors.dart';
import 'package:flutter_auto_flip/constant/fonts.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';
// import 'package:flutter_auto_flip/constant/colors.dart';

// 納品書を表示するカード
class DeliveryCard extends StatelessWidget {
  const DeliveryCard({super.key, required this.deliveryDate, required this.deliveryData, this.isRed = false, this.onTapDelite, this.edit = false, this.editController});

  final void Function(Delivery)? onTapDelite; // タップ時の処理
  final DateTime deliveryDate;
  final Delivery deliveryData;
  final bool isRed; // 赤文字表示
  final bool edit; // 編集モード
  final List<Map<String, TextEditingController>>? editController;

  @override
  Widget build(BuildContext context) {
    // セルにパディングを設定
    Widget buildTableCell(String text, {bool isLeft = false, bool? isEdit, TextEditingController? controller}) {
      return isEdit ?? edit
          ? Container(
              alignment: isLeft ? Alignment.centerLeft : Alignment.center,
              padding: const EdgeInsets.only(top: 5, bottom: 3, left: 5, right: 5),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  isDense: true, // 高さを抑える
                  contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5), // 内部のパディングを削除
                  border: InputBorder.none, // 枠線をなくす（必要に応じて）
                ),
              ))
          : Container(
              alignment: isLeft ? Alignment.centerLeft : Alignment.center,
              padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
              child: Text(text, textAlign: TextAlign.center),
            );
    }

    return InkWell(
        onTap: onTapDelite != null ? () => onTapDelite!(deliveryData) : null,
        child: Container(
          width: edit ? 480 : 450,
          height: edit ? 275 : 240,
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
                  '${deliveryData.customerName} 様',
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
                columnWidths: edit
                    ? const <int, TableColumnWidth>{
                        0: FixedColumnWidth(200),
                        1: FixedColumnWidth(55),
                        2: FixedColumnWidth(55),
                        3: FixedColumnWidth(55),
                        4: FixedColumnWidth(65),
                      }
                    : const <int, TableColumnWidth>{
                        0: FixedColumnWidth(200),
                        1: FixedColumnWidth(50),
                        2: FixedColumnWidth(50),
                        3: FixedColumnWidth(50),
                        4: FixedColumnWidth(60),
                      },
                children: [
                  TableRow(children: [
                    buildTableCell('誌名', isEdit: false),
                    buildTableCell('号数', isEdit: false),
                    buildTableCell('数量', isEdit: false),
                    buildTableCell('単価', isEdit: false),
                    buildTableCell('価格', isEdit: false),
                  ]),
                  for (int i = 0; i < deliveryData.magazines.length; i++)
                    edit
                        ? TableRow(children: [
                            buildTableCell(deliveryData.magazines[i].magazineName, isLeft: true, controller: editController![i]['magazineName']),
                            buildTableCell(deliveryData.magazines[i].magazineNumber, controller: editController![i]['magazineNumber']),
                            buildTableCell(deliveryData.magazines[i].quantity.toString(), controller: editController![i]['quantity']),
                            deliveryData.magazines[i].quantity == 1 ? buildTableCell('') : buildTableCell(NumberFormatProcess.formatNumberWithComma(deliveryData.magazines[i].unitPrice)),
                            buildTableCell(NumberFormatProcess.formatNumberWithComma(deliveryData.magazines[i].quantity * deliveryData.magazines[i].unitPrice),
                                controller: editController![i]['price']),
                          ])
                        : TableRow(children: [
                            buildTableCell(deliveryData.magazines[i].magazineName, isLeft: true),
                            buildTableCell(deliveryData.magazines[i].magazineNumber),
                            buildTableCell(deliveryData.magazines[i].quantity.toString()),
                            deliveryData.magazines[i].quantity == 1 ? buildTableCell('') : buildTableCell(NumberFormatProcess.formatNumberWithComma(deliveryData.magazines[i].unitPrice)),
                            buildTableCell(NumberFormatProcess.formatNumberWithComma(deliveryData.magazines[i].quantity * deliveryData.magazines[i].unitPrice)),
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
