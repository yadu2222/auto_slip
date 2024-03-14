import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auto_flip/data/regular_manager.dart';

import 'package:path_provider/path_provider.dart'; // アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

class PageMagazinesCount extends StatefulWidget {
  @override
  _PageMagazinesCountState createState() => _PageMagazinesCountState();
}

class _PageMagazinesCountState extends State<PageMagazinesCount> {
  // 入力された内容を保持するコントローラ
  final outputController = TextEditingController();

  // 表示するリスト
  List regulerData = [];
  // 冊数のチェックに使う
  int magazineCount = 0;

  @override
  Widget build(BuildContext context) {
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    // 雑誌コード、雑誌名に対して　店舗名と冊数　配達なのか店取りなのかを表示したい
    Widget regulerCard(int index) {
      return ListTile(
        title: Container(
          width: screenSizeWidth * 0.6,
          // height: screenSizeHeight * 0.1,
          alignment: Alignment.center,
          child: Column(
            children: [
              // 一番最初である、または
              // 一つ前のデータと雑誌コードが同一かを判別
              index == 0 || regulerData[index]["magazine_code"] != regulerData[index - 1]["magazine_code"]
                  ? Container(
                      width: screenSizeWidth * 0.6,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(regulerData[index]["magazine_code"].toString()),
                              SizedBox(width: screenSizeWidth * 0.02),
                              Text(regulerData[index]["magazine_name"]),
                              SizedBox(width: screenSizeWidth * 0.02),
                              Text(regulerData[index]["quantity_in_stock"].toString()),
                            ],
                          )))
                  : const SizedBox.shrink(),

              Container(
                  alignment: Alignment.center,
                  child: Row(children: [
                    Text(regulerData[index]["store_name"]),
                    SizedBox(width: screenSizeWidth * 0.02),
                    Text(regulerData[index]["quantity"].toString()),
                  ]))
            ],
          ),
        ),
      );
    }

    Widget regulerList() {
      return Container(
          width: screenSizeWidth * 0.6,
          height: screenSizeHeight * 0.5,
          alignment: Alignment.topCenter,
          child: ListView.builder(
            itemCount: regulerData.length,
            itemBuilder: (BuildContext context, int index) {
              return regulerCard(index);
            },
          ));
    }

    Widget regulerTable() {
      return DataTable(columns: const [
        DataColumn(label: Text('雑誌コード')),
        DataColumn(label: Text('雑誌名')),
        DataColumn(label: Text('冊数')),
        DataColumn(label: Text('店舗名')),
      ], rows: [
        for (int i = 0; i < regulerData.length; i++)
          DataRow(cells: [
            DataCell(Text(regulerData[i]["magazine_code"].toString())),
            DataCell(Text(regulerData[i]["magazine_name"])),
            DataCell(Text(regulerData[i]["quantity"].toString())),
            DataCell(Text(regulerData[i]["store_name"])),
          ]),
      ]);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('定期の数をチェックしよう'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSizeWidth * 0.4,
                  height: screenSizeHeight * 0.05,
                  // 入荷データのファイル読み込み
                  // 印刷までしたい
                  child: ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        String path = result.files.single.path!;
                        // 選択したファイルのパスを取得して処理を行う

                        List resultData = await RegulerManager.getImportData(path);

                        setState(() {
                          regulerData = resultData;
                        });
                      } else {
                        // ファイルが選択されなかった場合の処理
                      }
                    },
                    child: const Text('読み込むファイルを選択'),
                  ),
                ),
                regulerList()
              ],
            ),
          ),
        ));
  }
}

// Future<List> readCSV(String csvFilePath) async {
//   List<String> targetColumns = ["書店コード", "地区名", "書店名", "送品日付", "陳列", "雑誌コード", "号数", "日付", "年", "出版社名", "雑誌名", "冊数", "本体価格", "特号", "予約数", "伝票番号", "商品コード", "発行形態", "判型", "束数", "端数", "ISBNコード"];

//   List<Map<String, dynamic>> data = [];
//   print("呼び出したよ");

//   try {
//     // CSVファイルからデータ読み込み
//     String csvContent = await File(csvFilePath).readAsString(encoding: latin1);

//     List<List<dynamic>> csvList = const CsvToListConverter().convert(csvContent, eol: '\r\n');
//     List<String> header = csvList[0].map((dynamic e) => e.toString()).toList();

//     for (int i = 1; i < csvList.length; i++) {
//       Map<String, dynamic> dataMap = {};
//       for (int j = 0; j < header.length; j++) {
//         if (targetColumns.contains(header[j])) {
//           dataMap[header[j]] = csvList[i][j].toString();
//           print(csvList[i][j].toString());
//           print("はいってるよ");
//         }
//       }
//       data.add(dataMap);
//     }
//     return data;
//   } catch (e) {
//     print(e);
//     return [];
//   }
// }
