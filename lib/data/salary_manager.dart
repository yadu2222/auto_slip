import 'package:flutter/material.dart';
import '../data/process.dart';
import 'package:flutter_auto_flip/data/database_helper.dart';

class SalaryManager {
  // 従業員情報の追加
  static Future<void> addEmp(String empName, int salary) async {
    Map<String, dynamic> newEmp = {
      'emp_name': empName,
      'salary': salary,
    };
    await DatabaseHelper.insert('employee', newEmp);
  }

  // 従業員情報の更新
  static Future<void> updateEmp(int empId, String empName, int salary) async {
    Map<String, dynamic> updEmp = {
      'emp_name': empName,
      'salary': salary,
    };
    await DatabaseHelper.update('employee', "emp_id", updEmp, empId);
  }

  // 従業員情報の削除
  static Future<void> removeEmployee(int empId) async {
    await DatabaseHelper.delete('employee', "emp_num", empId);
  }

  // 従業員情報の参照
  static Future<List> getEmp(String? empName) async {
    if (empName != "") {
      if (empName != null) {
        debugPrint("検索はしてるよ");
        // List empList = await DatabaseHelper.serachRows('employee', 6, ['emp_name'], [empName], "emp_id");
        List empList = await DatabaseHelper.serachRows('employee', 1, ['emp_name'], [empName], "emp_id");
        debugPrint(empList[0]["emp_name"]);

        if (empList.isEmpty) {
          debugPrint("検索結果は空だよ");
          List empList = await DatabaseHelper.serachRows('employee', 1, ['emp_name'], [empName], "emp_id");
          debugPrint(empList[0]["emp_name"]);
        }
        return empList;
      } else {
        return [];
      }
    } else if (empName == "てんちょ") {
      List empList = await DatabaseHelper.serachRows('employee', 0, [], [], "emp_id");
      print(empList);
      return empList;
    } else {
      return [];
    }
  }

  // 従業員の勤怠情報の取得
  static Future<List> getEmpWorkTime(int empId) async {
    List workTimeList = await DatabaseHelper.serachRows('employee', 6, ['emp_id'], [empId], "emp_id");
    return workTimeList;
  }

  static Future<List> getEmpList() async {
    List empList = await DatabaseHelper.serachRows('employee', 0, [], [], "emp_id");
    return empList;
  }

  // 勤務時間の追加
  static Future<void> addWorkTime(int empId, DateTime recordDay, String startTime, String endTime, String breakTime) async {
    Map<String, dynamic> newWorkTime = {'emp_id': empId, 'record_day': recordDay.toString(), 'start_time': startTime, 'end_time': endTime, 'break_time': breakTime};
    await DatabaseHelper.insert('worktime', newWorkTime);
  }

  String getBetWeenTime(DateTime betWeenTime, int type) {
    // typeが0の場合はx月24日、typeが１の場合はx＋１月23日を返す

    // 24日以降であれば今の月の23日を返す
    switch (type) {
      case 0:
        if (betWeenTime.day > 23) {
          return "${betWeenTime.year}-${betWeenTime.month}-24";
        } else {
          // 24日以前であれば前の月の24日を返す
          if (betWeenTime.month == 1) {
            // 1月だと前年の12月24日を返す
            return "${betWeenTime.year - 1}-12-24";
          }
          return "${betWeenTime.year}-${betWeenTime.month - 1}-24";
        }
      case 2:
        if (betWeenTime.day > 23) {
          if (betWeenTime.month == 12) {
            return "${betWeenTime.year + 1}-1-23";
          }
          return "${betWeenTime.year}-${betWeenTime.month + 1}-23";
        } else {
          // 24日以前であれば今の月の24日を返す
          return "${betWeenTime.year}-${betWeenTime.month}-23";
        }
    }
    return "";
  }

  // 勤務時間の参照
  static Future<List> getWorkTime(int empId, DateTime betWeenTime) async {
    String startDay = Process.dateformat(betWeenTime.toString(), 6);
    String endDay = Process.dateformat(betWeenTime.add(const Duration(days: 30)).toString(), 7); // 次の月
    // TODO: 日付の範囲指定を実装
    List workTime = await DatabaseHelper.serachRows('worktime', 7, ['emp_id'], [empId, startDay, endDay], "record_day");
    print(workTime);
    return workTime;
  }

  // 勤務時間の更新
  static Future<void> updateWorkTime(int workId, int empId, String recordDay, String startTime, String endTime) async {
    Map<String, dynamic> updWorkTime = {
      'emp_id': empId,
      'record_day': recordDay,
      'start_time': startTime,
      'end_time': endTime,
    };
    await DatabaseHelper.update('worktime', "work_id", updWorkTime, workId);
  }

  // 勤務時間の削除
  static Future<void> deleteWorkTime(int workId) async {
    await DatabaseHelper.delete('worktime', "work_id", workId);
  }
}
