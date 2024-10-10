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
    return Customer.resToCustomer(resData['srvResData']); // 変換して返す
  }

  // 名前で検索して取得
  static Future<List<Customer>> searchCustomerName(String customerName) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getCustomer,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
      parData: customerName,
    );
    final resData = await HttpReq.httpReq(reqData);
    return Customer.resToCustomer(resData['srvResData']); // 変換して返す
  }

  // 顧客登録
  static Future<void> addCustomer(Customer customer) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.registerCustomer,
      reqType: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: {'customerName': customer.customerName,'ruby':customer.ruby, 'methodType': customer.regularType, 'tellType': customer.tellType, 'tellAddress': customer.address, 'note': customer.note},
    );
    await HttpReq.httpReq(reqData);
  }

  // 顧客情報更新
  static Future<void> updateCustomer(Customer customer) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.updateUser,
      reqType: 'PUT',
      headers: {'Content-Type': 'application/json'},
      body: { 'customerUUId':customer.customerUUID,'customerName': customer.customerName, 'methodType': customer.regularType, 'tellType': customer.tellType, 'tellAddress': customer.address, 'note': customer.note},
    );
    await HttpReq.httpReq(reqData);
  }

  // 顧客を削除
  static Future<void> deliteCustomer(String customerUUID) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.deliteCustomer,
      reqType: 'DELETE',
      headers: {'Content-Type': 'application/json'},
      parData: customerUUID
    );
    await HttpReq.httpReq(reqData);
  }
}
