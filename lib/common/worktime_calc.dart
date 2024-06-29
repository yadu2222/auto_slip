class WorkTimeCalc {
  // TODO:日付超えると勤務時間がマイナスになるので一応修正
  static String workTimeCalc(List workList, int index) {
    String result = "";

    String originStartTime = workList[index]['start_time'];
    String originEndTime = workList[index]['end_time'];
    String originBreakTime = workList[index]['break_time'];

    // 文字列をリストに入れて抜き出し
    List<String> startTime = originStartTime.split(":");
    List<String> endTime = originEndTime.split(":");
    List<String> breakTime = originBreakTime.split(":");

    // 時間を変数に挿入
    int startHour = int.parse(startTime[0]);
    int startMinute = int.parse(startTime[1]);
    int endHour = int.parse(endTime[0]);
    int endMinute = int.parse(endTime[1]);
    int breakHour = int.parse(breakTime[0]);
    int breakMinute = int.parse(breakTime[1]);

    // 勤務時間計算
    int totalWorkMinutes = (endHour * 60 + endMinute) - (startHour * 60 + startMinute);
    // 休憩時間計算
    int totalBreakMinutes = breakHour * 60 + breakMinute;
    // 実働時間計算
    int netWorkMinutes = totalWorkMinutes - totalBreakMinutes;
    // 結果を文字列に整形
    int netWorkHours = netWorkMinutes ~/ 60;
    int remainingMinutes = netWorkMinutes % 60;

    if (remainingMinutes < 10) {
      result = "$netWorkHours:0$remainingMinutes";
      return result;
    }

    result = "$netWorkHours:$remainingMinutes";
    return result;
  }

  static String totalWorkTimeCalc(List workList) {
    String result = "";
    List totalWorkTime = [];

    // 各日の実働時間を計算
    for (int i = 0; i < workList.length; i++) {
      totalWorkTime.add(workTimeCalc(workList, i));
    }

    // 各日の時間を合計
    int totalMinutes = 0;
    for (String workTime in totalWorkTime) {
      List<String> timeComponents = workTime.split(":");
      int hours = int.parse(timeComponents[0]);
      int minutes = int.parse(timeComponents[1]);
      totalMinutes += hours * 60 + minutes;
    }

    // 合計時間を整形
    int totalHours = totalMinutes ~/ 60;
    int remainingMinutes = totalMinutes % 60;
    if (remainingMinutes < 10) {
      result = "$totalHours:0$remainingMinutes";
      return result;
    }

    result = "$totalHours:$remainingMinutes";
    return result;
  }
}
