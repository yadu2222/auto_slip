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
  static const String getCustomer = '$version/customers'; // GETお客様情報取得
  static const String registerUser = '$version/users/register'; // POSTユーザー登録
  static const String login = '$version/users/login'; // POSTログイン
  static const String getUser = '$version/auth/users/user'; // GETuser情報取得

  // employee

  // magazine
  static const String registerforCSVMagazine = '$version/csv/magazines'; // POST csvから雑誌登録
  static const String getMagazines = '$version/magazines/magazines'; // GET雑誌情報取得
  static const String getMagazineByCode = '$version/magazines/magazine'; // GET雑誌情報取得
  static const String getMagazineByName = '$version/magazines/magazines'; // POST雑誌登録

  // regular
  static const String getMagazineRegular = '$version/regulars/regulars/magazines'; // GET定期購読雑誌情報取得  
  static const String countingRegular = '$version/csv/counting'; // GET定期購読数取得  
}
