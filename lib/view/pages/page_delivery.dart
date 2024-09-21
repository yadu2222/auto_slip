import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/delivery_controller.dart';
import 'package:flutter_auto_flip/common/number_format.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/organisms/delivery_list.dart';
import 'package:flutter_auto_flip/view/components/organisms/main_menu.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class PageDelivery extends HookWidget {
  PageDelivery({super.key});

  // 新規登録
  final TextEditingController newStoreNameController = TextEditingController(); // 新しい店舗名
  final TextEditingController newCountController = TextEditingController(); // 新しい店舗名

  @override
  Widget build(BuildContext context) {
    DeliveryReq deliveryReq = DeliveryReq(context: context);
    final deliveryList = useState<List<Delivery>>([]);
    final deliveryDate = useState<DateTime>(DateTime.now());

    // 押したカードを配列から削除
    void deleteDelivery(Delivery delivery) {
      // リストのコピーを作成してから削除
      final updatedList = List<Delivery>.from(deliveryList.value);
      updatedList.remove(delivery);
      // リストを再代入してUIを更新
      deliveryList.value = updatedList;
    }

    // 消していいか確認のダイアログ
    void deliteDialog(Delivery delivery) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('削除確認'),
            content: Text('${delivery.customerName}様の納品書を削除しますか？'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // 角を丸くしない
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () {
                  deleteDelivery(delivery);
                  Navigator.of(context).pop();
                },
                child: const Text('削除'),
              ),
            ],
          );
        },
      );
    }

    Future<void> print(pw.Document pdf) async {
      final Uint8List pdfData = await pdf.save();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfData,
      );
    }

    Future<void> printWidgetToPdf() async {
      // コンテンツを分割してPDFページを作成
      final pdf = pw.Document();
      const itemsPerRow = 2; // 1行あたりのカード数
      const rowsPerPage = 5; // 1ページあたりの行数
      const cardsPerPage = itemsPerRow * rowsPerPage; // 1ページあたりのカード数
      const cardWidth = 270.0; // カードの幅
      const cardHeight = 155.0; // カードの高さ

      final fontData = await rootBundle.load('assets/fonts/NotoSansJP-Regular.ttf'); // 文字化け対策にフォントを読み込み
      final ttf = pw.Font.ttf(fontData);

      for (int i = 0; i < deliveryList.value.length; i += cardsPerPage) {
        final endIndex = (i + cardsPerPage < deliveryList.value.length) ? i + cardsPerPage : deliveryList.value.length;
        final pageItems = deliveryList.value.sublist(i, endIndex);

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
            margin: pw.EdgeInsets.zero, // 余白をなくす

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
                              pw.Text('${deliveryDate.value.year}/${deliveryDate.value.month}/${deliveryDate.value.day}', style: pw.TextStyle(font: ttf, fontSize: 8)),
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

      // // PDFをファイルに保存
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/paged_listview.pdf');
      // await file.writeAsBytes(await pdf.save());

      // print('PDF saved to ${file.path}');

      // PDFを印刷
      print(pdf);
    }

    Future<File?> loadFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        return File(result.files.single.path!);
      } else {
        return null;
      }
    }

    // TODO:バリデーション
    // csvのみ受付？
    Future<void> getDelivery() async {
      // ファイルを読み込み
      File? file = await loadFile();
      if (file == null) {
        // TODO: ファイルが選択されなかった場合の処理
        return;
      }
      await deliveryReq.getDeliveryHandler(file).then((value) => deliveryList.value = value);
    }

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: deliveryDate.value,
        firstDate: DateTime(deliveryDate.value.year - 1),
        lastDate: DateTime(deliveryDate.value.year + 5),
      );

      if (picked != null) {
        deliveryDate.value = picked;
      }
    }

    return Scaffold(
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  const MainMenu(),
                  Expanded(
                      child: Column(children: [
                    AppBar(
                      title: const Text('伝票を作ろう'),
                      actions: [
                        IconButton(
                          onPressed: () {
                            printWidgetToPdf();
                          },
                          icon: const Icon(
                            Icons.print,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    // 日付を入れてもらう
                    BasicButton(width: 300, text: 'ファイルを選択してね', isColor: true, onPressed: () => getDelivery()),
                    BasicButton(width: 300, text: '納品する日付 : ${deliveryDate.value.year}/${deliveryDate.value.month}/${deliveryDate.value.day}', isColor: true, onPressed: () => _selectDate(context)),
                    // 数取リストの有無で表示を制御
                    deliveryList.value.isEmpty
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: SingleChildScrollView(
                            child: DeliveryList(
                              onTapDelite: deliteDialog,
                              deliveries: deliveryList.value,
                              deliveryDate: deliveryDate.value,
                            ),
                          ))
                  ]))
                ]))));
  }
}
