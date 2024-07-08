import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import './view/pages/page_home.dart';

import 'router/router.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  GoRouter? _router; // GoRouterのインスタンス// null許容
  // ルーターの初期化を非同期で行う
  Future<void> _initializeRouter() async {
    final router = await createRouter(); // 非同期でルーターを取得
    setState(() {
      _router = router; // 取得したルーターを状態にセット
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeRouter();
  }

  @override
  Widget build(BuildContext context) {
    if (_router == null) {
      // ルーターが初期化されていない場合、ローディングインジケーターを表示
      return const CircularProgressIndicator();
    }
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, //デバッグの表示を消す
      // theme: ThemeData(
      //   // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.main),
      //   // useMaterial3: true,
      //   // appBarTheme: const AppBarTheme(backgroundColor: AppColors.main, iconTheme: IconThemeData(color: AppColors.iconLight)),
      // ),
      routerConfig: _router!, // ルーティングの設定
    );  
  }
}


// import 'dart:io';
// import 'package:http/http.dart' as http;

// void main() async {
//   var file = File('path_to_your_csv_file.csv'); // 送信するCSVファイルのパスを指定する

//   // ファイルを読み込む
//   List<int> bytes = await file.readAsBytes();

//   var request = http.MultipartRequest('POST', Uri.parse('http://localhost:8080/upload'));
//   request.files.add(http.MultipartFile.fromBytes('file', bytes, filename: 'data.csv'));

//   try {
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       print('CSVファイルの処理が完了しました');
//       print(await response.stream.bytesToString());
//     } else {
//       print('サーバーからエラーが返されました: ${response.reasonPhrase}');
//     }
//   } catch (e) {
//     print('リクエスト中にエラーが発生しました: $e');
//   }
// }

// class MyHomePage extends StatelessWidget {
//   List<Map<String, dynamic>> printData = [
//     {
//       "sName": "エリタージュ",
//       "data": [
//         {
//           "magazineName": "女性自身",
//           "release": "6/9",
//           "quantity": "1",
//           "price": "",
//           "totalPrice": "480",
//         },
//         {
//           "magazineName": "女性自身",
//           "release": "6/9",
//           "quantity": "1",
//           "price": "",
//           "totalPrice": "480",
//         },
//         {
//           "magazineName": "kanasiine",
//           "release": "6/9",
//           "quantity": "1",
//           "price": "",
//           "totalPrice": "480",
//         },
//       ],
//     },
//     {
//       "sName": "かなりあ",
//       "data": [
//         {
//           "magazineName": "女性自身",
//           "release": "6/9",
//           "quantity": "1",
//           "price": "",
//           "totalPrice": "480",
//         },
//         {
//           "magazineName": "女性自身",
//           "release": "6/9",
//           "quantity": "1",
//           "price": "",
//           "totalPrice": "480",
//         },
//         {
//           "magazineName": "kanasiine",
//           "release": "6/9",
//           "quantity": "1",
//           "price": "",
//           "totalPrice": "480",
//         },
//       ],
//     },
//   ];

//   // font読み込み
//   Future<pw.Font> _loadFont() async {
//     final fontData = await rootBundle.load("assets/fonts/NotoSansJP-Bold.ttf");
//     return pw.Font.ttf(fontData.buffer.asByteData());
//   }

//   Future<void> _printPdf(List<Map<String, dynamic>> printData) async {
//     final pdf = pw.Document();
//     final font = await _loadFont();
//     final pw.TextStyle cellStyle = pw.TextStyle(font: font, fontSize: 12);

//     for (var item in printData) {
//       pdf.addPage(pw.Page(
//           // ここで渡したウィジェットでPDFをのページを作成
//           build: (pw.Context context) => pw.Center(
//                   child: pw.Container(
//                       child: pw.Column(
//                 children: [
//                   pw.Text(
//                     "納品書",
//                     style: cellStyle,
//                   ),
//                   pw.Row(children: [
//                     pw.Text(
//                       item["sName"],
//                       style: (pw.TextStyle(
//                         font: font,
//                         fontSize: 12,
//                         fontWeight: pw.FontWeight.bold,
//                         decoration: pw.TextDecoration.underline,
//                       )),
//                     ),
//                     pw.Text("松田書店", style: cellStyle),
//                   ]),
//                   pw.TableHelper.fromTextArray(
//                     context: context,
//                     data: <List<String>>[
//                       <String>['品名', '号数', '数量', '単価', '金額'],
//                       for (var data in item["data"]) <String>[data["magazineName"], data["release"], data["quantity"], data["price"], data["totalPrice"]],
//                     ],
//                     headerStyle: cellStyle,
//                     cellStyle: cellStyle,
//                   ),
//                   pw.Text('2024.5.28', style: pw.TextStyle(font: font)),
//                 ],
//               )))));
//     }

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => pdf.save(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter PDF Printing'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           // 非同期関数
//           onPressed: () async {
//             await _printPdf(printData);
//           },
//           child: Text('Print PDF'),
//         ),
//       ),
//     );
//   }
// }
