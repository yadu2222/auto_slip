import 'package:flutter/material.dart';
import '../parts/parts.dart';

class EditPage extends StatefulWidget {
  // 0で店舗情報、1で雑誌情報、2で定期情報
  int editType;
  String code; // 編集するデータの識別子
  EditPage(this.editType, this.code);

  @override
  _EditPageState createState() => _EditPageState();
}

/**
 * 
 *  編集ページ
 *  ・店舗情報
 *  ・雑誌情報
 *  ・定期情報
 */

class _EditPageState extends State<EditPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController magazineNameController = TextEditingController();
  TextEditingController magazineCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget mainDisp(int editType) {
      return Center(
          child: Center(
        child: Column(
          children: [
            // あなたは誰ですか？
            // 編集者の名前を残す
            Container()
          ],
        ),
      ));
    }

    return DefaultTabController(
      initialIndex: 0, // 初期選択タブ
      length: 3, // タブの数
      child: Scaffold(
        appBar: AppBar(
          title: const Text('編集'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: '連絡先',
              ),
              Tab(
                text: '雑誌',
              ),
              Tab(
                text: '定期',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // mainDisp(),
            // mainDisp(),
            // mainDisp(),
          ],
        ),
      ),
    );
  }
}
