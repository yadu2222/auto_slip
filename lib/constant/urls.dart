class Urls {
  // base URL
  static const String protocol = 'http://';
  static const String host = 'localhost';
  static const String port = '8080';
  static const String baseUrl = '$protocol$host:$port';
  static const String version = '/v1'; // version

  // test
  static const String test = '$version/test/cfmreq'; // GET接続確認

  // ここにURLを追加していく
  // customer
  static const String getCustomer = '$version/customers/customers'; // GETお客様情報取得
  static const String registerCustomer = '$version/customers/register'; // POSTユーザー登録
  static const String login = '$version/users/login'; // POSTログイン
  static const String updateUser = '$version/customers/update'; // POSTuser情報更新
  static const String deliteCustomer = '$version/customers/delete'; // POSTユーザー削除

  // employee

  // magazine
  static const String registerforCSVMagazine = '$version/csv/magazines'; // POST csvから雑誌登録
  static const String getMagazines = '$version/magazines/magazines'; // GET雑誌情報取得
  static const String getMagazineByCode = '$version/magazines/magazine'; // GET雑誌情報取得
  static const String getMagazineByName = '$version/magazines/magazines'; // POST雑誌登録
  static const String registerMagazine = '$version/magazines/register'; // POST雑誌登録
  static const String updateMagazine = '$version/magazines/update'; // POST雑誌更新
  static const String deleteMagazine = '$version/magazines/delete'; // POST雑誌削除

  // regular
  static const String getMagazineRegular = '$version/regulars/regulars'; // GET定期購読雑誌情報取得
  static const String countingRegular = '$version/csv/counting'; // GET定期購読数取得
  static const String getMagazineRegularByCustomerName = '$version/regulars/regulars/customer'; // POST顧客名で定期購読雑誌情報取得
  static const String getRegularByMagazineCode = '$version/regulars/regulars/magazine/code'; // POST雑誌コードで定期購読雑誌情報取得
  static const String getRegularByMagazineName = '$version/regulars/regulars/magazine/name'; // POST雑誌コードで定期購読雑誌情報取得
  static const String registerRegular = '$version/regulars/register'; // POST定期購読登録
  static const String deleteRegular = '$version/regulars/delete'; //

  // test
  static const String csvMagazine = '$version/csv/magazines'; // POST csvから雑誌登録
  static const String csvRegular = '$version/csv/regulars'; // POST csvから定期購読登録
  static const String csvCustomer = '$version/csv/customers'; // POST csvから定期購読数取得

  // delivery
  static const String getDelivery = '$version/deliveries/deliveries'; // GET配送情報取得
}
