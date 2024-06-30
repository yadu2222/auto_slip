import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// model
import '../../models/load_regular_model.dart';
// common
import '../../common/file_con.dart'; // ファイル操作
// view
import '../template/basic_template.dart';
import '../organisms/regular_list.dart';
// constant
import '../../constant/sample_data.dart';

class PageMagazineCount extends HookWidget {
  const PageMagazineCount({super.key});

  final String title = '定期の数をチェックしよう';
  final String buttonMsg = '読み込むファイルを選択';

  @override
  Widget build(BuildContext context) {
    final regularList = useState<LoadRegular>(SampleData.loadRegular);

    return BasicTemplate(
      title: title,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 入荷データのファイル読み込み
          // 印刷までしたい
          ElevatedButton(
            onPressed: () async {
              FileController.fileGet();
            },
            child: Text(buttonMsg),
          ),
          Expanded(child: RegularList(regularList: regularList.value))
        ],
      ),
    );
  }
}


    // Widget regulerList() {
    //   return Container(
    //       width: screenSizeWidth * 0.6,
    //       height: screenSizeHeight * 0.8,
    //       alignment: Alignment.topCenter,
    //       child: ListView.builder(
    //         itemCount: regulerData.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return regulerCard(index);
    //         },
    //       ));
    // }


    // Widget regulerTable() {
    //   return DataTable(columns: const [
    //     DataColumn(label: Text('雑誌コード')),
    //     DataColumn(label: Text('雑誌名')),
    //     DataColumn(label: Text('冊数')),
    //     DataColumn(label: Text('店舗名')),
    //   ], rows: [
    //     for (int i = 0; i < regulerData.length; i++)
    //       DataRow(cells: [
    //         DataCell(Text(regulerData[i]["magazine_code"].toString())),
    //         DataCell(Text(regulerData[i]["magazine_name"])),
    //         DataCell(Text(regulerData[i]["quantity"].toString())),
    //         DataCell(Text(regulerData[i]["store_name"])),
    //       ]),
    //   ]);
    // }


// // 雑誌コード、雑誌名に対して　店舗名と冊数　配達なのか店取りなのかを表示したい
// Widget regulerCard(int index) {
//   bool isbool = index == 0 || regulerData[index]["magazine_code"] != regulerData[index - 1]["magazine_code"];

//   String regularType = regulerData[index]["regular_type"] == "0"
//       ? "配達"
//       : regulerData[index]["regular_type"] == "1"
//           ? "店取り"
//           : regulerData[index]["regular_type"] == "2"
//               ? "店取り伝票"
//               : "図書館";

//   Widget isWidget = Row(
//     children: [
//       Text(regulerData[index]["magazine_code"].toString()),
//       SizedBox(width: screenSizeWidth * 0.02),
//       Text(regulerData[index]["magazine_name"]),
//       SizedBox(width: screenSizeWidth * 0.02),
//       Text("入荷数：" + regulerData[index]["quantity_in_stock"].toString()),
//     ],
//   );
//   Widget repeatWidget = Row(
//     children: [
//       Text(regulerData[index]["store_name"]),
//       SizedBox(width: screenSizeWidth * 0.02),
//       Text(regularType),
//       SizedBox(width: screenSizeWidth * 0.02),
//       Text(regulerData[index]["quantity"].toString()),
//     ],
//   );

//   String code = regulerData[index]["regular_id"].toString();
//   return Parts.dispListCard(isbool, isWidget, repeatWidget, screenSizeWidth, screenSizeHeight, context, code);
// }

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

// return ListTile(
      //   title: Container(
      //     width: screenSizeWidth * 0.6,
      //     // height: screenSizeHeight * 0.1,
      //     alignment: Alignment.center,
      //     child: Column(
      //       children: [
      //         // 一番最初である、または
      //         // 一つ前のデータと雑誌コードが同一かを判別
      //         index == 0 || regulerData[index]["magazine_code"] != regulerData[index - 1]["magazine_code"]
      //             ? Container(
      //                 width: screenSizeWidth * 0.6,
      //                 decoration: const BoxDecoration(
      //                   border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
      //                 ),
      //                 child: Container(
      //                     alignment: Alignment.center,
      //                     child: Row(
      //                       children: [
      //                         Text(regulerData[index]["magazine_code"].toString()),
      //                         SizedBox(width: screenSizeWidth * 0.02),
      //                         Text(regulerData[index]["magazine_name"]),
      //                         SizedBox(width: screenSizeWidth * 0.02),
      //                         Text(regulerData[index]["quantity_in_stock"].toString()),
      //                       ],
      //                     )))
      //             : const SizedBox.shrink(),

      //         Container(
      //             alignment: Alignment.center,
      //             child: Row(children: [
      //               Text(regulerData[index]["store_name"]),
      //               SizedBox(width: screenSizeWidth * 0.02),
      //               Text(regulerData[index]["quantity"].toString()),
      //             ]))
      //       ],
      //     ),
      //   ),
      // );
