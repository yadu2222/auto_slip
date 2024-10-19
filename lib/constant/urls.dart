class Urls {
  // base URL
  static const String protocol = 'http://';
  static const String host = 'localhost';
  static const String port = '8080';
  static const String baseUrl = '$protocol$host:$port';
  static const String version = '/v2'; // version
  static const String auth = '/auth';

  // test
  static const String test = '$version/test/cfmreq'; // GET接続確認

  // ここにURLを追加していく

  // login 
  static const String login = '$version/login'; // POSTログイン

  // customer
  static const String getCustomer = '$version$auth/customers/customers'; // GETお客様情報取得
  static const String registerCustomer = '$version$auth/customers/register'; // POSTユーザー登録
  static const String updateUser = '$version$auth/customers/update'; // POSTuser情報更新
  static const String deliteCustomer = '$version$auth/customers/delete'; // POSTユーザー削除

  // employee

  // magazine
  static const String registerforCSVMagazine = '$version$auth/csv/magazines'; // POST csvから雑誌登録
  static const String getMagazines = '$version$auth/magazines/magazines'; // GET雑誌情報取得
  static const String getMagazineByCode = '$version$auth/magazines/magazine'; // GET雑誌情報取得
  static const String getMagazineByName = '$version$auth/magazines/magazines'; // POST雑誌登録
  static const String registerMagazine = '$version$auth/magazines/register'; // POST雑誌登録
  static const String updateMagazine = '$version$auth/magazines/update'; // POST雑誌更新
  static const String deleteMagazine = '$version$auth/magazines/delete'; // POST雑誌削除

  // regular
  static const String getMagazineRegular = '$version$auth/regulars/regulars'; // GET定期購読雑誌情報取得
  static const String countingRegular = '$version$auth/csv/counting'; // GET定期購読数取得
  static const String getMagazineRegularByCustomerName = '$version$auth/regulars/regulars/customer'; // POST顧客名で定期購読雑誌情報取得
  static const String getRegularByMagazineCode = '$version$auth/regulars/regulars/magazine/code'; // POST雑誌コードで定期購読雑誌情報取得
  static const String getRegularByMagazineName = '$version$auth/regulars/regulars/magazine/name'; // POST雑誌コードで定期購読雑誌情報取得
  static const String registerRegular = '$version$auth/regulars/register'; // POST定期購読登録
  static const String deleteRegular = '$version$auth/regulars/delete'; //

  // test
  static const String csvMagazine = '$version$auth/csv/magazines'; // POST csvから雑誌登録
  static const String csvRegular = '$version$auth/csv/regulars'; // POST csvから定期購読登録
  static const String csvCustomer = '$version$auth/csv/customers'; // POST csvから定期購読数取得

  // delivery
  static const String getDelivery = '$version$auth/deliveries/deliveries'; // GET配送情報取得
}
