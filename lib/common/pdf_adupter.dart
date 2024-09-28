import 'package:flutter_auto_flip/models/delivery_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_auto_flip/common/number_format.dart';

class PdfAdupter {


  // 納品書のPDFを作成
  Future<pw.Document> getDeliveryDocument(List<Delivery> deliveryList,DateTime deliveryDate) async{
    // コンテンツを分割してPDFページを作成
      final pdf = pw.Document();
      const itemsPerRow = 2; // 1行あたりのカード数
      const rowsPerPage = 5; // 1ページあたりの行数
      const cardsPerPage = itemsPerRow * rowsPerPage; // 1ページあたりのカード数
      const cardWidth = 270.0; // カードの幅
      const cardHeight = 155.0; // カードの高さ

      final fontData = await rootBundle.load('assets/fonts/NotoSansJP-Regular.ttf'); // 文字化け対策にフォントを読み込み
      final ttf = pw.Font.ttf(fontData);

      for (int i = 0; i < deliveryList.length; i += cardsPerPage) {
        final endIndex = (i + cardsPerPage < deliveryList.length) ? i + cardsPerPage : deliveryList.length;
        final pageItems = deliveryList.sublist(i, endIndex);

        // セルにパディングを設定
        pw.Widget buildTableCell(String text, {bool left = false}) {
          return pw.Container(
            height: 15, // セルの高さを固定
            alignment: left ? pw.Alignment.centerLeft : pw.Alignment.topCenter, // セル内のコンテンツを中央に配置
            padding: const pw.EdgeInsets.symmetric(vertical: 2, horizontal: 5), // パディングの調整
            child: pw.Text(
              text,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(font: ttf, fontSize: 8),
            ),
          );
        }

        pdf.addPage(
          pw.Page(
            margin: const pw.EdgeInsets.all(30),

            // pageFormat: pageSize,
            build: (pw.Context context) {
              return pw.Center(
                  child: pw.Column(
                // 1ページに表示する行数分だけ繰り返す
                children: List.generate((pageItems.length / itemsPerRow).ceil(), (rowIndex) {
                  final startIndex = rowIndex * itemsPerRow; // 左
                  final endIndex = startIndex + itemsPerRow; // 右
                  final rowItems = pageItems.sublist(startIndex, endIndex > pageItems.length ? pageItems.length : endIndex); // 1行分のデータを取得

                  return pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: rowItems.map((delivery) {
                      return pw.Container(
                        width: cardWidth,
                        height: cardHeight,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        padding: const pw.EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        child: pw.Column(
                          children: [
                            pw.Text('納品書', style: pw.TextStyle(font: ttf, fontSize: 10)),
                            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                              pw.Text('${delivery.customerName} 様', style: pw.TextStyle(font: ttf, fontSize: 10)),
                              pw.Text('松田書店', style: pw.TextStyle(font: ttf, fontSize: 8)),
                            ]),
                            pw.SizedBox(height: 3),
                            pw.Table(
                              border: pw.TableBorder.all(),
                              columnWidths: {
                                // 幅を固定
                                0: const pw.FixedColumnWidth(120),
                                1: const pw.FixedColumnWidth(30),
                                2: const pw.FixedColumnWidth(25),
                                3: const pw.FixedColumnWidth(30),
                                4: const pw.FixedColumnWidth(30),
                              },
                              children: [
                                pw.TableRow(children: [
                                  buildTableCell('品名'),
                                  buildTableCell('号数'),
                                  buildTableCell('数量'),
                                  buildTableCell('単価'),
                                  buildTableCell('金額'),
                                ]),
                                for (var magazine in delivery.magazines)
                                  pw.TableRow(children: [
                                    buildTableCell(magazine.magazineName, left: true),
                                    buildTableCell(magazine.magazineNumber),
                                    buildTableCell(magazine.quantity.toString()),
                                    magazine.quantity == 1 ? buildTableCell('') : buildTableCell(NumberFormatProcess.formatNumberWithComma(magazine.unitPrice)),
                                    buildTableCell(NumberFormatProcess.formatNumberWithComma(magazine.quantity * magazine.unitPrice)),
                                  ]),
                                // データが5行未満の場合に空行を追加
                                if (delivery.magazines.length < 5)
                                  for (var i = 0; i < 5 - delivery.magazines.length; i++)
                                    pw.TableRow(children: [
                                      buildTableCell(''),
                                      buildTableCell(''),
                                      buildTableCell(''),
                                      buildTableCell(''),
                                      buildTableCell(''),
                                    ]),
                              ],
                            ),
                            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                              pw.Text('${deliveryDate.year}/${deliveryDate.month}/${deliveryDate.day}', style: pw.TextStyle(font: ttf, fontSize: 8)),
                            ]),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
              ));
            },
          ),
        );
      }
    return pdf;
  }
}
