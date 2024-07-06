import '../http_req.dart';
import '../../models/customer_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class CustomerService {


  // お客様情報の取得
  static Future<void> getCustomer(Map<String, dynamic> reqBody) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.registerUser,
      reqType: 'POST',
      body: reqBody,
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);
  }
}
