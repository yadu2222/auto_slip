import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_flip/data/salary_manager.dart';
import '../../data/regular_manager.dart';
import '../../data/process.dart';

class salaryPage extends StatefulWidget {
  @override
  _salaryPageState createState() => _salaryPageState();
}

class _salaryPageState extends State<salaryPage> {
  // 日付用変数
  static DateTime editDate = DateTime.now();
  static DateTime selectedDate = DateTime.now();

  // 入力された内容を保持するコントローラ
  TextEditingController _empUserController = TextEditingController();
  TextEditingController _recordDayController = TextEditingController(text: "${editDate.month.toString()}/${editDate.day.toString()}");
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _breakTimeController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  List empList = [];
  List workList = [];

  @override
  Widget build(BuildContext context) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    // 基本的な数字
    double widthData = 0.7;
    double heightData = 0.1;

    Widget searchButton(String searchRoom) {
      return IconButton(
          icon: Icon(Icons.send), // Replace 'some_icon' with the desired icon
          onPressed: () async {
            FocusScope.of(context).unfocus(); //キーボードを閉じる
            debugPrint("なにがはいってるのかというと[${_empUserController.text}]");
            setState(() {});
          });
    }

    Widget addWorkDataButton() {
      return InkWell(
        onTap: () async {
          bool isEdit = _recordDayController.text != "" && _startTimeController.text != "" && _endTimeController.text != "" && _breakTimeController.text != "";

          if (isEdit) {
            await SalaryManager.addWorkTime(empList[0]["emp_id"], editDate, _startTimeController.text, _endTimeController.text, _breakTimeController.text);
            debugPrint("追加処理");

            editDate = DateTime.now();
            _recordDayController = TextEditingController(text: "${editDate.month.toString()}/${editDate.day.toString()}");
            _startTimeController.clear();
            _endTimeController.clear();
            _breakTimeController.clear();

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      // dialogの角丸
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    title: const Text("追加完了"),
                    content: const Text("追加が完了しました"),
                    actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      // dialogの角丸
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    title: const Text("エラー"),
                    content: const Text("全ての項目を入力してください"),
                    actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }

          setState(() {});
        },
        child: Container(
          width: screenSizeWidth * 0.2,
          height: screenSizeHeight * 0.06,
          margin: EdgeInsets.all(screenSizeHeight * 0.02),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(1)),
          child: const Text(
            "追加",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    // 入力フォーム
    // 入力用コントローラー, ヒント, 最大文字数, 文字列かどうか
    Widget editForm(TextEditingController controller, String hintText, int maxLength, bool edit) {
      return Container(
        width: screenSizeWidth * 0.125,
        height: screenSizeHeight * heightData,
        margin: EdgeInsets.all(screenSizeWidth * 0.02),
        alignment: Alignment.center,
        child: edit
            ? TextField(
                enabled: true,
                maxLength: maxLength,
                maxLines: 1,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                ),
              )
            : TextField(
                enabled: true,
                maxLength: maxLength,
                maxLines: 1,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // 数字と：のみの入力を受け付ける
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9:]*$')),
                  // _TimeInputFormatter(),
                ],
              ),
      );
    }

    // 日付の入力
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: editDate,
        // locale: const Locale('ja'), // 日本語を指定
        firstDate: DateTime(2024),
        lastDate: DateTime(2035),
      );

      if (picked != null) {
        setState(() {
          editDate = picked;
          _recordDayController = TextEditingController(text: "${editDate.month.toString()}/${editDate.day.toString()}");
        });
      }
    }

    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTIme = TimeOfDay.now();

    Future<void> _selectTime(BuildContext context, TimeOfDay selectedTime) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          // 選択された時刻を変数に格納
          selectedTime = picked;
          if (selectedTime == startTime) {
            _startTimeController = TextEditingController(text: selectedTime.hour.toString() + ":" + selectedTime.minute.toString());
          } else {
            _endTimeController = TextEditingController(text: selectedTime.hour.toString() + ":" + selectedTime.minute.toString());
          }
        });
      }
    }

    Widget _selectTimeButton(BuildContext context, TimeOfDay selectedTime) {
      return InkWell(
        onTap: () {
          _selectTime(context, selectedTime);
        },
        child: SizedBox(
          child: Text(selectedTime.hour.toString() + ":" + selectedTime.minute.toString()),
        ),
      );
    }

    // 出勤情報の入力
    Widget editData() {
      // 幅
      var width = screenSizeWidth * widthData;
      var height = screenSizeHeight * heightData;
      return Container(
          width: width,
          height: height * 3,
          alignment: Alignment.center,
          child: Column(children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: SizedBox(
                    child: Text(_recordDayController.text, style: const TextStyle(fontSize: 15)),
                  ),
                ),
                // _selectTimeButton(context, startTime),
                // editForm(_recordDayController, "日付", 5),
                editForm(_startTimeController, "出勤時間", 5, false),
                editForm(_endTimeController, "退勤時間", 5, false),
                editForm(_breakTimeController, "休憩時間", 5, false),
                editForm(_noteController, "備考", 5, true)
              ],
            ),
            addWorkDataButton()
          ]));
    }

    // 検索バー
    Widget searchBar() {
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
                          Icons.person,
                          size: 30,
                          color: Colors.black,
                        )),

                    Container(
                        width: screenSizeWidth * 0.5,
                        height: screenSizeHeight * 0.04,
                        alignment: const Alignment(0.0, 0.0),
                        // テキストフィールド
                        child: TextField(
                          controller: _empUserController,
                          decoration: const InputDecoration(
                            hintText: '名前を入力してください',
                          ),
                          textInputAction: TextInputAction.search,
                        )),
                    SizedBox(
                      width: screenSizeWidth * 0.01,
                    ),
                    // やじるし 検索ボタン
                    searchButton(_empUserController.text),
                  ],
                )
              ]));
    }

    Widget workDataTable() {
      return DataTable(columns: const [
        DataColumn(label: Text(" ")),
        DataColumn(label: Text('日付')),
        DataColumn(label: Text('出勤')),
        DataColumn(label: Text('退勤')),
        DataColumn(label: Text('休憩')),
        DataColumn(label: Text('実働'))
      ], rows: [
        for (int i = 0; i < workList.length; i++)
          DataRow(cells: [
            DataCell(IconButton(
                onPressed: () async {
                  await SalaryManager.deleteWorkTime(workList[i]['work_id']);
                  setState(() {});
                },
                icon: const Icon(Icons.delete))),
            DataCell(Text(Process.dateformat(workList[i]['record_day'], 5))),
            DataCell(Text(workList[i]['start_time'])),
            DataCell(Text(workList[i]['end_time'])),
            DataCell(Text(workList[i]['break_time'])),
            DataCell(Text(Process.workTimeCalc(workList, i))),
          ]),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('勤怠管理'),
        // appbarにアイコンを追加
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () => {},
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.remove),
        //     onPressed: () => {},
        //   ),
        // ],
      ),
      body: Center(
        child: Column(children: [
          searchBar(),
          FutureBuilder(
            future: SalaryManager.getEmp(_empUserController.text),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  debugPrint("なにがはいってるのかというと3[${_empUserController.text}]");
                  return Text('Error: ${snapshot.error}');
                } else {
                  // futureから帰ってきたデータを挿入
                  // Widgetを表示
                  debugPrint("なにがはいってるのかというと2[${_empUserController.text}]");
                  empList = snapshot.data;
                  debugPrint(DateTime.now().toString());
                  return Container(
                      width: screenSizeWidth * widthData,
                      height: screenSizeHeight * heightData * 7,
                      alignment: Alignment.topCenter,
                      child: empList.length == 0
                          ? const SizedBox.shrink()
                          : Column(children: [
                              Text("${empList[0]["emp_name"]}さんの${selectedDate.month.toString()}月の勤怠"),
                              editData(),
                              FutureBuilder(
                                  future: SalaryManager.getWorkTime(empList[0]["emp_id"], selectedDate),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        // futureから帰ってきたデータを挿入
                                        // Widgetを表示
                                        debugPrint("なにがはいってるのかというと2[${_empUserController.text}]");
                                        workList = snapshot.data;
                                        return Container(
                                            width: screenSizeWidth * widthData,
                                            height: screenSizeHeight * heightData * 3,
                                            child: ListView(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text("合計実働時間: ${Process.totalWorkTimeCalc(workList)}"),
                                                ),
                                                workDataTable(),
                                              ],
                                            ));
                                      }
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  })
                            ]));
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    // Stateがdisposeされる際に、TextEditingControllerも破棄する
    _empUserController.dispose();
    super.dispose();
  }
}

// class _TimeInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     if (newValue.text.length == 3 && !oldValue.text.endsWith(':')) {
//       // Automatically add ':' after the first 2 digits
//       return TextEditingValue(
//         text: '${newValue.text.substring(0, 2)}:${newValue.text.substring(2)}',
//         selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
//       );
//     }
//     return newValue;
//   }
// }
