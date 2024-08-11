import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// model
import '../../models/load_regular_model.dart';
// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as regular_list;
import '../components/organisms/regular_list.dart';
// constant
import '../../constant/sample_data.dart';

// class PageRegular extends HookWidget {
//   PageRegular({super.key});

//   // コントローラー
//   final _storeNameController = TextEditingController();
//   final _magazineController = TextEditingController();
//   final _magazineNameController = TextEditingController();

//   // どちらで検索しているかを判別する変数

//   final String title = '定期一覧';
//   final String storeNameSearch = '店舗名で検索';
//   final String magazineCodeSearch = '雑誌コードで検索';
//   final String magazineNameSearch = '誌名で検索';

//   @override
//   Widget build(BuildContext context) {
//     final regularList = useState<LoadRegular>(SampleData.loadRegular2);
//     // final searchType = useState<int>(0); // 0で店舗名検索、1で雑誌コード検索、2で雑誌名検索

//     Future<void> serchButtonFunction() async {
//       // TODO：検索処理
//       // タイプ切り替え
//     }

//     return BasicTemplate(
//         title: title,
//         floatingActionButton: IconButton(
//           onPressed: () {
//             // 編集画面に遷移
//             context.go('/home/add');
//           },
//           icon: const Icon(Icons.add, size: 30),
//         ),
//         child: Column(children: [
//           // 検索バー
//           regular_list.EditBarView(
//             icon: Icons.storefront,
//             hintText: storeNameSearch,
//             controller: _storeNameController,
//             search: serchButtonFunction,
//           ),
//           regular_list.EditBarView(
//             icon: Icons.local_offer,
//             hintText: magazineCodeSearch,
//             controller: _magazineController,
//             search: serchButtonFunction,
//           ),
//           regular_list.EditBarView(
//             icon: Icons.import_contacts,
//             hintText: magazineNameSearch,
//             controller: _magazineNameController,
//             search: serchButtonFunction,
//           ),
//           // searchType.value == 0 ? Expanded(child: RegularList(regularList: regularList.value)) : Expanded(child: MagazineRegularList(regularList: regularList.value))
//           Expanded(child: RegularList.headerCustomer(regularList: regularList.value))
//         ]));
//   }
// }

// 店舗名優先表示カード
    // Widget storeListCard(int index) {
    //   return ListTile(
    //       // 押されたときの動作
    //       // TODO:DB検索と表示
    //       onTap: () async {
    //         // 編集画面に遷移
    //       },
    //       title: Container(
    //         width: screenSizeWidth * widthData,
    //         alignment: Alignment.center,
    //         child: Column(
    //           children: [
    //             index == 0 || regularList[index]["store_name"] == regularList[index - 1]["store_name"]
    //                 ? Container(
    //                     width: screenSizeWidth * widthData * 0.8,
    //                     decoration: const BoxDecoration(
    //                       border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
    //                     ),
    //                     child: Text(
    //                       regularList[index]["store_name"],
    //                     ),
    //                   )
    //                 : SizedBox.shrink(),
    //             Container(
    //                 alignment: Alignment.center,
    //                 child: Row(children: [
    //                   Text(regularList[index]["magazine_code"].toString()),
    //                   SizedBox(width: screenSizeWidth * 0.02),
    //                   Text(regularList[index]["magazine_name"]),
    //                   SizedBox(width: screenSizeWidth * 0.02),
    //                   Text(regularList[index]["quantity"].toString() + "冊")
    //                 ]))
    //           ],
    //         ),
    //       ));
    // }

    // // 雑誌優先表示カード
    // Widget magazinesCard(int index) {
    //   return ListTile(
    //       title: InkWell(
    //           onTap: () {
    //             // 編集画面に遷移
    //           },
    //           child: Container(
    //             width: screenSizeWidth * 0.6,
    //             // height: screenSizeHeight * 0.1,
    //             alignment: Alignment.center,
    //             child: Column(
    //               children: [
    //                 // 一番最初である、または
    //                 // 一つ前のデータと雑誌コードが同一かを判別
    //                 index == 0 || regularList[index]["magazine_code"] != regularList[index - 1]["magazine_code"]
    //                     ? Container(
    //                         width: screenSizeWidth * 0.6,
    //                         decoration: const BoxDecoration(
    //                           border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
    //                         ),
    //                         child: Container(
    //                             alignment: Alignment.center,
    //                             child: Row(
    //                               children: [
    //                                 Text(regularList[index]["magazine_code"].toString()),
    //                                 SizedBox(width: screenSizeWidth * 0.02),
    //                                 Text(regularList[index]["magazine_name"]),
    //                                 // SizedBox(width: screenSizeWidth * 0.02),
    //                                 // Text(regularList[index]["quantity_in_stock"].toString()),
    //                               ],
    //                             )))
    //                     : const SizedBox.shrink(),

    //                 Container(
    //                     alignment: Alignment.center,
    //                     child: Row(children: [
    //                       Text(regularList[index]["store_name"]),
    //                       SizedBox(width: screenSizeWidth * 0.02),
    //                       Text(regularList[index]["quantity"].toString()),
    //                     ]))
    //               ],
    //             ),
    //           )));
    // }

     // Widget searchButton(int changeType) {
    //   return IconButton(
    //       icon: Icon(Icons.send), // Replace 'some_icon' with the desired icon
    //       onPressed: () async {
    //         FocusScope.of(context).unfocus(); //キーボードを閉じる
    //         setState(() {
    //           // 切り替え
    //           if (changeType == 0) {
    //             searchType = 0;
    //             debugPrint(searchType.toString());
    //           } else if (changeType == 1) {
    //             searchType = 1;
    //             debugPrint(searchType.toString());
    //           } else {
    //             searchType = 2;
    //             debugPrint(searchType.toString());
    //           }
    //         });
    //       });
    // }

    // // 検索バー
    // Widget searchBar(IconData icon, String hintText, TextEditingController controller, int addType) {
    //   return // 検索バー
    //       Container(
    //           width: screenSizeWidth * widthData,
    //           //height: screenSizeHeight * 0.067,
    //           decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238), borderRadius: BorderRadius.circular(50)),
    //           margin: EdgeInsets.all(screenSizeWidth * 0.02),
    //           child: Column(children: [
    //             Row(
    //               children: [
    //                 // 検索アイコン
    //                 Container(
    //                     margin: EdgeInsets.only(right: screenSizeWidth * 0.02, left: screenSizeWidth * 0.02),
    //                     child: Icon(
    //                       icon,
    //                       size: 30,
    //                       // color: Colors.grey,
    //                     )),

    //                 Container(
    //                     width: screenSizeWidth * 0.4,
    //                     height: screenSizeHeight * 0.04,
    //                     alignment: const Alignment(0.0, 0.0),
    //                     // テキストフィールド
    //                     child: TextField(
    //                       controller: controller,
    //                       decoration: InputDecoration(
    //                         hintText: hintText,
    //                       ),
    //                       textInputAction: TextInputAction.search,
    //                     )),
    //                 SizedBox(
    //                   width: screenSizeWidth * 0.01,
    //                 ),
    //                 // やじるし 検索ボタン
    //                 searchButton(addType),
    //               ],
    //             )
    //           ]));
    // }
