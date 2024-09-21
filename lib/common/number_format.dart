import 'package:intl/intl.dart';

// ここまでファイル分割する必要あるのか〜〜！？！？！？！？
class NumberFormatProcess{
      // カンマを入れるメソッド
  static String formatNumberWithComma(num number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}