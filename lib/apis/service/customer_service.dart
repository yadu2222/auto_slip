import '../http_req.dart';
import '../../models/customer_model.dart';
import '../../constant/urls.dart';
import '../../models/req_model.dart';

class CustomerService {
  // お客様情報の取得
  static Future<List<Customer>> getCustomer() async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getCustomer,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);
    return Customer.resToCustomer(resData['srvResData']);   // 変換して返す
  }
}
