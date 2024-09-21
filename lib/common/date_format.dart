import 'package:intl/intl.dart';


class DateFormatProcess{

   // 日付を変換して返す
  static String dateformat(String dateTime, int type) {
    final formatType_1 = DateFormat('yyyy.MM.dd HH:mm');
    final formatType_2 = DateFormat('yyyy/MM/dd');
    final formatType_3 = DateFormat('HH:mm');
    final formatType_4 = DateFormat('MM月dd日HH時mm分');
    final formatType_5 = DateFormat('MM.dd.HH時mm分');
    final formatType_6 = DateFormat('MM/dd');
    final formatType_7 = DateFormat('yyyy-MM-24'); // 日付指定用
    final formatType_8 = DateFormat('yyyy-MM-23'); // 日付指定用

    print(dateTime);
    List formatType = [formatType_1, formatType_2, formatType_3, formatType_4, formatType_5, formatType_6, formatType_7, formatType_8];
    DateTime nn = DateTime.parse(dateTime);
    return formatType[type].format(nn);
  }
}