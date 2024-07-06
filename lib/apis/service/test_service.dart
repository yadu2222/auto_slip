import '../http_req.dart';

import '../../constant/urls.dart';
import '../../models/req_model.dart';

class TestService {


  // 接続確認
  static Future<void> connectTest() async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.test,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);
    print(resData['srvResMsg'].toString());
  }
}
