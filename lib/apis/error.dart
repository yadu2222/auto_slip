import '../constant/messages.dart';
import '../view/components/atoms/toast.dart';

// APIとの通信における例外集

// enumおじさんになることで可読性が上がる？気がする
enum ExceptionType { AuthException,DefaultException }

// ひもづけ
extension ExceptionTypeExtension on ExceptionType {
  // 値を保持するためのMapを使用
  static final Map<ExceptionType, int> _values = {};
  String get message {
    switch (this) {
      case ExceptionType.AuthException:
        return Messages.StatusUnauthorized;
      case ExceptionType.DefaultException:
        return Messages.StatusInternalServerError;
    }
  }

  int get value => _values[this] ?? 0;

  set value(int newValue) {
    if (newValue < 0 || newValue > 4) {
      _values[this] = 4;
    } else {
      _values[this] = newValue;
    }
  }
}

// 例外を渡してtoast表示
void handleException(ExceptionType exceptionType) {
  // ここでToastを表示
  ToastUtil.show(message: exceptionType.message);
}

// ーーーー ここに足していってね ーーーー
// enumとひもづけに足すことも忘れずに

// 宿題が空のとき
class AuthException implements Exception {
  final String message;
  const AuthException({this.message = Messages.StatusUnauthorized});
}

class DefaultException implements Exception {
  final String message;
  const DefaultException({this.message = Messages.StatusInternalServerError});
}



