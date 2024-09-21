import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/delivery_controller.dart';
import 'package:flutter_auto_flip/common/pdf_adupter.dart';
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
    final delete = useState<bool>(false);

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
      // コンテンツをPDFに変換
      PdfAdupter pdfAdupter = PdfAdupter();
      final pdf = await pdfAdupter.getDeliveryDocument(deliveryList.value, deliveryDate.value);

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
        return;
      }
      await deliveryReq.getDeliveryHandler(file).then((value) => deliveryList.value = value);
    }

    Future<void> selectDate(BuildContext context) async {
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

    // 削除モードと切り替え
    void deliteSwitch() {
      delete.value = !delete.value;
    }

    Future<void> onTapCard(Delivery delivery) async {
      delete.value ? deliteDialog(delivery) : null;
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
                        Row(children: [
                          // ごみばこ
                          IconButton(
                            onPressed: () {
                              deliteSwitch();
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: delete.value ? Colors.red : null,
                            ),
                          ),
                          // 印刷
                          IconButton(
                            onPressed: () {
                              printWidgetToPdf();
                            },
                            icon: const Icon(
                              Icons.print,
                              size: 30,
                            ),
                          ),
                        ])
                      ],
                    ),
                    // 日付を入れてもらう
                    BasicButton(width: 300, text: 'ファイルを選択してね', isColor: true, onPressed: () => getDelivery()),
                    BasicButton(width: 300, text: '納品する日付 : ${deliveryDate.value.year}/${deliveryDate.value.month}/${deliveryDate.value.day}', isColor: true, onPressed: () => selectDate(context)),
                    // 数取リストの有無で表示を制御
                    deliveryList.value.isEmpty
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: SingleChildScrollView(
                            child: DeliveryList(
                              onTapDelite: onTapCard,
                              deliveries: deliveryList.value,
                              deliveryDate: deliveryDate.value,
                            ),
                          ))
                  ]))
                ]))));
  }
}
