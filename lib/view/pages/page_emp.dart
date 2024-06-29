import 'package:flutter/material.dart';
import '../../apis/controller/salary_manager.dart';

class PageEmp extends StatefulWidget {
  @override
  _PageEmpState createState() => _PageEmpState();
}

class _PageEmpState extends State<PageEmp> {
  // 入力用のコントローラー
  TextEditingController _passController = TextEditingController();
  TextEditingController _empNameController = TextEditingController();
  TextEditingController _empSalaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    // 基本的な数字
    double widthData = 0.6;
    double heightData = 0.1;

    // 表示用のリスト
    List empList = [];
    bool admin = true;

    Widget checkButton(String passWord) {
      return IconButton(
          icon: const Icon(Icons.check), // Replace 'some_icon' with the desired icon
          onPressed: () async {
            FocusScope.of(context).unfocus(); //キーボードを閉じる

            // List newList = await RegulerManager.getsearchData(searchRoom);
            List newList = await SalaryManager.getEmpList();

            setState(() {
              // TODO: ここでadminを判定する
              admin = true;
              // empList = newList;
            });
          });
    }

    // 検索バー
    Widget editPass() {
      debugPrint("admin");
      return // 検索バー
          Container(
              width: screenSizeWidth * widthData,
              //height: screenSizeHeight * 0.067,
              decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238), borderRadius: BorderRadius.circular(50)),
              margin: EdgeInsets.all(screenSizeWidth * 0.02),
              child: Column(children: [
                Row(
                  children: [
                    // 検索アイコン
                    Container(
                        margin: EdgeInsets.only(right: screenSizeWidth * 0.02, left: screenSizeWidth * 0.02),
                        child: const Icon(
                          Icons.key,
                          size: 30,
                          color: Colors.black,
                        )),

                    Container(
                        width: screenSizeWidth * 0.4,
                        height: screenSizeHeight * 0.04,
                        alignment: const Alignment(0.0, 0.0),
                        // テキストフィールド
                        child: TextField(
                          controller: _passController,
                          decoration: const InputDecoration(
                            hintText: 'パスワードを入力してください',
                          ),
                          textInputAction: TextInputAction.search,
                        )),
                    SizedBox(
                      width: screenSizeWidth * 0.01,
                    ),
                    // やじるし 検索ボタン
                    checkButton(_passController.text),
                  ],
                )
              ]));
    }

    Widget empListCard(int index) {
      return ListTile(
        onTap: () {
          // 押されたときの動作
        },
        title: Container(
            width: screenSizeWidth * widthData,
            alignment: Alignment.center,
            child: Row(children: [Text(empList[index]["emp_name"]), SizedBox(width: screenSizeWidth * 0.02), Text(empList[index]["salary"].toString())])),
      );
    }

    // 定期情報の入力
    Widget editEmpData() {
      // 幅
      var width = screenSizeWidth * widthData;
      var height = screenSizeHeight * heightData;
      return // 定期情報の入力
          Container(
        width: width,
        height: height * 2,
        alignment: Alignment.center,
        child: Row(
          children: [
            // 名前
            Container(
              width: width / 2 - width * 0.01,
              height: height,
              alignment: Alignment.center,
              child: TextField(
                enabled: true,
                maxLength: 20,
                maxLines: 1,
                controller: _empNameController,
                decoration: const InputDecoration(
                  hintText: '名前',
                ),
              ),
            ),

            SizedBox(
              width: width * 0.02,
            ),

            // 時給
            Container(
                width: width / 2 - width * 0.01,
                height: height,
                alignment: Alignment.center,
                child: TextField(
                  enabled: true,
                  maxLength: 10,
                  maxLines: 1,
                  controller: _empSalaryController,
                  decoration: const InputDecoration(
                    hintText: '時給',
                  ),
                )),
          ],
        ),
      );
    }

    // 定期追加確定ボタン
    Widget addRegularButton() {
      //画面サイズ
      var screenSizeWidth = MediaQuery.of(context).size.width;
      var screenSizeHeight = MediaQuery.of(context).size.height;
      return InkWell(
        onTap: () async {
          // 条件確認
          bool isName = _empNameController.text != "";
          bool isSalary = _empSalaryController.text != "";
          String errorText = isName && isSalary
              ? ""
              : isName
                  ? "時給を入力してください"
                  : isSalary
                      ? "名前を入力してください"
                      : "名前と時給を入力してください";

          // どちらも空じゃなければ
          if (isName && isSalary) {
            // 定期追加処理
            await SalaryManager.addEmp(_empNameController.text, int.parse(_empSalaryController.text));
            debugPrint("追加処理");
            // 完了ダイアログ
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      // dialogの角丸
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    title: const Text('完了'),
                    content: const Text('従業員の追加が完了しました'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          } else {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      // dialogの角丸
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    title: const Text('エラー'),
                    content: Text(errorText),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }

          setState(() {});
        },
        child: Container(
          width: screenSizeWidth * 0.2,
          height: screenSizeHeight * 0.065,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(1)),
          child: const Text(
            "追加",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    Widget empDataTable() {
      return DataTable(columns: [
        const DataColumn(label: Text('名前')),
        const DataColumn(label: Text('時給'))
      ], rows: [
        for (int i = 0; i < empList.length; i++)
          DataRow(cells: [
            DataCell(Text(empList[i]['emp_name'])),
            DataCell(Text(empList[i]['salary'].toString())),
          ]),
      ]);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('従業員情報'),
        ),
        body: Center(
            child: Container(
          child: Column(children: [
            editPass(),
            editEmpData(),
            addRegularButton(),
            admin
                ? FutureBuilder(
                    future: SalaryManager.getEmpList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // futureから帰ってきたデータを挿入
                          // Widgetを表示
                          debugPrint("なにがはいってるのかというと[${_passController.text}]");
                          empList = snapshot.data;
                          //   return Container(
                          //       width: screenSizeWidth * widthData * 0.8,
                          //       height: screenSizeHeight * heightData * 5,
                          //       alignment: Alignment.topCenter,
                          //       child: ListView.builder(
                          //           itemCount: empList.length,
                          //           itemBuilder: (BuildContext context, int index) {
                          //             return empListCard(index);
                          //           }));
                          // }
                          return Container(
                              width: screenSizeWidth * widthData * 0.8, height: screenSizeHeight * heightData * 5, alignment: Alignment.topCenter, child: ListView(children: [empDataTable()]));
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  )
                : const SizedBox.shrink()
          ]),
        )));
  }

  @override
  void dispose() {
    // Stateがdisposeされる際に、TextEditingControllerも破棄する
    _passController.dispose();
    super.dispose();
  }
}
