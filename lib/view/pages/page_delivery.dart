import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';
import 'package:flutter_auto_flip/view/components/organisms/delivery_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart'; // これが必要です
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
    final deliveryList = useState<List<Delivery>>(Delivery.sampleDelibery);

    final GlobalKey printKey = GlobalKey();

    Future<void> printWidgetToPdf(GlobalKey widgetKey) async {
      // // RepaintBoundary内のウィジェットを画像に変換
      // final boundary = widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;

      // if (boundary != null) {
      //   final image = await boundary.toImage(pixelRatio: 2.0);
      //   final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      //   final pngBytes = byteData!.buffer.asUint8List();

      //   final pdf = pw.Document();
      //   final pdfImage = pw.MemoryImage(pngBytes);

      //   pdf.addPage(
      //     pw.Page(
      //       build: (pw.Context context) => pw.Center(child: pw.Image(pdfImage)),
      //     ),
      //   );

      //   // PDFを直接印刷
      //   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
      // } else {
      //   print("Error: RenderRepaintBoundaryが見つかりませんでした");
      // }

      try {
        // コンテンツを分割してPDFページを作成
        final pdf = pw.Document();
        const itemsPerRow = 2; // 1行あたりのカード数
        const rowsPerPage = 5; // 1ページあたりの行数
        const cardsPerPage = itemsPerRow * rowsPerPage; // 1ページあたりのカード数
        const cardWidth = 270.0; // カードの幅
        const cardHeight = 130.0; // カードの高さ

        final fontData = await rootBundle.load('assets/fonts/NotoSansJP-Regular.ttf');
        final ttf = pw.Font.ttf(fontData);

        for (int i = 0; i < deliveryList.value.length; i += cardsPerPage) {
          final endIndex = (i + cardsPerPage < deliveryList.value.length) ? i + cardsPerPage : deliveryList.value.length;
          final pageItems = deliveryList.value.sublist(i, endIndex);

          // セルにパディングを設定
          pw.Widget buildTableCell(String text) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
              child: pw.Text(text, textAlign: pw.TextAlign.center, style: pw.TextStyle(font: ttf, fontSize: 8)),
            );
          }

          pdf.addPage(
            pw.Page(
              // pageFormat: pageSize,
              build: (pw.Context context) {
                return pw.Center(
                    child: pw.Column(
                  children: List.generate((pageItems.length / itemsPerRow).ceil(), (rowIndex) {
                    final startIndex = rowIndex * itemsPerRow;
                    final endIndex = startIndex + itemsPerRow;
                    final rowItems = pageItems.sublist(startIndex, endIndex > pageItems.length ? pageItems.length : endIndex);

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
                                pw.Text('${delivery.storeName} 様', style: pw.TextStyle(font: ttf, fontSize: 10)),
                                pw.Text('松田書店', style: pw.TextStyle(font: ttf, fontSize: 10)),
                              ]),
                              pw.SizedBox(height: 3),
                              pw.Table(
                                border: pw.TableBorder.all(),
                                columnWidths: {
                                  0: const pw.FixedColumnWidth(100),
                                  1: const pw.FixedColumnWidth(30),
                                  2: const pw.FixedColumnWidth(30),
                                  3: const pw.FixedColumnWidth(30),
                                  4: const pw.FixedColumnWidth(60),
                                },
                                children: [
                                  pw.TableRow(children: [
                                    buildTableCell('誌名'),
                                    buildTableCell('号数'),
                                    buildTableCell('数量'),
                                    buildTableCell('単価'),
                                    buildTableCell('価格'),
                                  ]),
                                  for (var magazine in delivery.magazines)
                                    pw.TableRow(children: [
                                      buildTableCell(magazine.magazineName),
                                      buildTableCell(magazine.magazineNumber),
                                      buildTableCell(magazine.quantity.toString()),
                                      magazine.quantity == 1 ? buildTableCell('') : buildTableCell(magazine.unitPrice.toString()),
                                      buildTableCell((magazine.quantity * magazine.unitPrice).toString()),
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
                                pw.Text(delivery.date, style: pw.TextStyle(font: ttf, fontSize: 8)),
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
        final Uint8List pdfData = await pdf.save();
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfData,
        );
      } catch (e) {
        print('Error capturing and printing: $e');
      }
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
    Future<void> counting() async {
      // ファイルを読み込み
      File? file = await loadFile();
      if (file == null) {
        // TODO: ファイルが選択されなかった場合の処理
        return;
      }
      // await regularReq.getRegularHandler(file).then((value) => deliveryList.value = value);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('伝票を作ろう'),
          actions: [
            InkWell(
              onTap: () {
                printWidgetToPdf(printKey);
              },
              child: const Icon(Icons.print),
            ),
          ],
        ),
        body: Center(
            child:
                // 数取リストの有無で表示を制御
                deliveryList.value.isEmpty
                    ? const SizedBox.shrink()
                    : SingleChildScrollView(
                        child: RepaintBoundary(
                          key: printKey,
                          child: DeliveryList(deliveries: deliveryList.value),
                        ),
                      )));
  }
}
