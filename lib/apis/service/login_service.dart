import '../http_req.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class LoginService {
  // csvで数取り
  static Future<String> login(String userId, String password) async {
    // リクエストを生成
    final reqData = Request(url: Urls.login, reqType: 'POST', headers: {'Content-Type': 'application/json'}, body: {'userId': userId, 'password': password}, isAuth: false);
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return resData['srvResData']['token'] ?? '';
  }
}
