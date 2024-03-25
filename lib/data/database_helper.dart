import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper(); // 無名のコンストラクタを追加

  static const _databaseName = "MyDatabase.db"; // DB名
  static const _databaseVersion = 1; // スキーマのバージョン指定

  // DatabaseHelper クラスを定義
  DatabaseHelper._privateConstructor();
  // DatabaseHelper._privateConstructor() コンストラクタを使用して生成されたインスタンスを返すように定義
  // DatabaseHelper クラスのインスタンスは、常に同じものであるという保証
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Databaseクラス型のstatic変数_databaseを宣言
  // クラスはインスタンス化しない
  static Database? _database;

  // databaseメソッド定義
  // 非同期処理
  Future<Database?> get database async {
    // _databaseがNULLか判定
    // NULLの場合、_initDatabaseを呼び出しデータベースの初期化し、_databaseに返す
    // NULLでない場合、そのまま_database変数を返す
    // これにより、データベースを初期化する処理は、最初にデータベースを参照するときにのみ実行されるようになります。
    // このような実装を「遅延初期化 (lazy initialization)」と呼びます。
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // データベース接続
  _initDatabase() async {
    // アプリケーションのドキュメントディレクトリのパスを取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 取得パスを基に、データベースのパスを生成
    String path = join(documentsDirectory.path, _databaseName);
    // データベース接続
    return await openDatabase(path,
        version: _databaseVersion,
        // テーブル作成メソッドの呼び出し
        onCreate: _onCreate);
  }

  // テーブル作成
  // 引数:dbの名前
  // 引数:スキーマーのversion
  // スキーマーのバージョンはテーブル変更時にバージョンを上げる（テーブル・カラム追加・変更・削除など）
  Future<void> _onCreate(Database db, int version) async {
    // 店舗を管理するためのテーブル
    // 店舗ID、店舗名
    await db.execute('''
    CREATE TABLE stores (
      store_id integer PRIMARY KEY autoincrement,
      store_name TEXT,
      regular_type TEXT,
      address text,
      tell_type text,
      note text
    )
  ''');

    // 雑誌を管理するためのテーブル
    // 雑誌ID、雑誌名
    await db.execute('''
    CREATE TABLE magazines (
      magazine_code text PRIMARY KEY,
      magazine_name TEXT
    )
  ''');

    // 定期を管理するためのテーブル
    // 定期ID、店舗ID、雑誌ID、数量
    await db.execute('''
    CREATE TABLE regulars (
      regular_id integer PRIMARY KEY autoincrement,
      store_id integer,
      magazine_code text,
      quantity integer
    )
  ''');

    // 従業員のテーブル
    await db.execute('''
    CREATE TABLE employee(
      emp_id integer PRIMARY KEY autoincrement,
      emp_name text,
      salary integer
    )
  ''');

    // 勤務時間のテーブル
    await db.execute('''
    CREATE TABLE worktime(
      work_id integer PRIMARY KEY autoincrement,
      emp_id integer,
      record_day text,
      start_time text,
      end_time text,
      break_time text
    )
    ''');
  }

  // 登録処理
  // 引数：table名、追加するmap
  static Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database? db = await instance.database;

    return await db!.insert(tableName, row);
  }

  // 照会処理
  // 引数：table名
  static Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database? db = await instance.database;
    // print(await db!.rawQuery("select * from $tableName"));
    return await db!.rawQuery("select * from $tableName");
  }

  // テーブル名、検索タイプ、検索行、検索ワード、ソート列
  static Future<List<Map<String, dynamic>>> searchRows(String tableName, int searchhType, List searchColum, List searchWords, String sort) async {
    Database? db = await instance.database;
    switch (searchhType) {
      // table名のみで検索
      case 0:
        return await db!.rawQuery("select * from $tableName");
      // 検索あり 1語
      case 1:
        return await db!.query(
          '$tableName',
          where: '${searchColum[0]} = ?',
          whereArgs: ['${searchWords[0]}'],
          orderBy: '${sort} ASC',
        );
      // 検索あり 2語
      case 2:
        return await db!.query(
          '$tableName',
          where: '${searchColum[0]} = ? AND ${searchColum[1]} = ?',
          whereArgs: ['${searchWords[0]}', '${searchWords[1]}'],
          orderBy: '${sort} ASC',
        );
      // 検索あり 3語
      case 3:
        return await db!.query(
          '$tableName',
          where: '${searchColum[0]} = ? AND ${searchColum[1]} = ? AND ${searchColum[2]} = ?',
          whereArgs: ['${searchWords[0]}', '${searchWords[1]}', '${searchWords[2]}'],
          orderBy: '${sort} ASC',
        );

      // TODO:getShiftを整備したら消すぞ
      case 6:
        debugPrint("とおってるよ");
        return await db!.rawQuery('''
      SELECT w.work_id, e.emp_name, w.record_day, w.start_time, w.end_time,w.break_time
      FROM employee AS e
      JOIN worktime AS w on e.emp_id = w.emp_id
      where w.emp_id = ? and w.record_day between ? and ?
    ''', [searchWords[0], searchWords[1], searchWords[2]]);

      // TODO:getShiftを整備したら消すぞ
      case 7:
        return await db!.query(
          '$tableName',
          where: '${searchColum[0]} = ? and record_day BETWEEN ? AND ?',
          whereArgs: [searchWords[0], searchWords[1], searchWords[2]],
          orderBy: '$sort ASC',
        );
    }
    return await db!.rawQuery("select * from $tableName");
  }

  // 勤怠情報取得
  static Future<List<Map<String, dynamic>>> getShift(int empId, String startTime, String endTime, int searchType) async {
    Database? db = await instance.database;
    return await db!.rawQuery('''
      SELECT w.work_id, e.emp_name, w.record_day, w.start_time, w.end_time,w.break_time
      FROM employee AS e
      JOIN worktime AS w on e.emp_id = w.emp_id
      where w.emp_id = ${empId} w.record_day between ${startTime} and ${endTime}
    ''');
  }

  // 定期一覧取得
  static Future<List<Map<String, dynamic>>> searchRegulerList(int searchType, String serchData) async {
    // db 接続
    Database? db = await instance.database;
    switch (searchType) {
      // 店舗名検索
      case 0:
        return await db!.rawQuery('''
      SELECT r.regular_id, s.store_name, m.magazine_code, m.magazine_name,r.quantity,s.regular_type, s.address,s.tell_type,s.note
      FROM stores AS s
      JOIN regulars AS r ON r.store_id = s.store_id
      JOIN magazines AS m ON r.magazine_code = m.magazine_code
      where s.store_name like '%${serchData}%'
      order by s.store_name asc
    ''');
      // 雑誌コード検索
      case 1:
        return await db!.rawQuery(
          '''
          SELECT r.regular_id, s.store_name, m.magazine_code, m.magazine_name,r.quantity
          FROM stores AS s
          JOIN regulars AS r ON r.store_id = s.store_id
          JOIN magazines AS m ON r.magazine_code = m.magazine_code
          where r.magazine_code = '${serchData}'
          order by m.magazine_code asc
        ''',
        );
      // 雑誌名検索
      case 2:
        return await db!.rawQuery(
          '''
          SELECT r.regular_id, s.store_name, m.magazine_code, m.magazine_name,r.quantity
          FROM stores AS s
          JOIN regulars AS r ON r.store_id = s.store_id
          JOIN magazines AS m ON r.magazine_code = m.magazine_code
          where m.magazine_name like '%${serchData}%'
          order by r.magazine_code asc
        ''',
        );
      // 店舗名優先検索
      case 10:
        return await db!.rawQuery('''
      SELECT r.regular_id, s.store_name, m.magazine_code, m.magazine_name,r.quantity,s.regular_type, s.address,s.tell_type,s.note
      FROM stores AS s
      JOIN regulars AS r ON r.store_id = s.store_id
      JOIN magazines AS m ON r.magazine_code = m.magazine_code
      order by s.store_name asc
    ''');
      // 雑誌コード優先検索
      case 11:
        return await db!.rawQuery('''
      SELECT r.regular_id, s.store_name, m.magazine_code, m.magazine_name,r.quantity
      FROM stores AS s
      JOIN regulars AS r ON r.store_id = s.store_id
      JOIN magazines AS m ON r.magazine_code = m.magazine_code
      order by m.magazine_code asc
    ''');
    }

    // 全件取得
    return await db!.rawQuery('''
      SELECT r.regular_id, s.store_name, m.magazine_code, m.magazine_name,r.quantity
      FROM stores AS s
      JOIN regulars AS r ON r.store_id = s.store_id
      JOIN magazines AS m ON r.magazine_code = m.magazine_code
      order by s.store_name asc
    ''');
  }

  static Future<bool> firstdb() async {
    Database? db = await instance.database;
    List result = await db!.rawQuery("select * from rooms");
    // 取得した結果が空でないかを確認し、存在する場合はtrueを、存在しない場合はfalseを返す
    return result.isNotEmpty;
  }

  // レコード数を確認
  // 引数：table名
  static Future<int?> queryRowCount(String tableName) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // 更新処理
  // 引数：table名、更新後のmap、検索キー
  static Future<int> update(String tableName, String colum, Map<String, dynamic> row, var key) async {
    Database? db = await instance.database;
    print(await db!.rawQuery("select * from $tableName"));
    return await db.update(tableName, row, where: '$colum = ?', whereArgs: ['$key']);
  }

  // 削除処理
  // 引数：table名、更新後のmap、検索キー
  static Future<int> delete(String tableName, String colum, var key) async {
    Database? db = await instance.database;
    return await db!.delete(tableName, where: '$colum = ?', whereArgs: [key]);
  }

  // 入荷データをdbに登録
  // テーブルを作成
  // 比較終わり次第削除する
  static Future<void> createImportDateTable() async {
    print("つくるよ");
    // db作成処理
    // 肝心のデータが文字化けしているので、雑誌コードと入荷数のみを登録する
    Database? db = await instance.database;
    await db!.execute('''
    CREATE TABLE importData (
      id integer PRIMARY KEY autoincrement,
      magazine_code text,
      quantity_in_stock integer
    )
  ''');
  }

  // 雑誌ちぇっく
  static Future<List<Map<String, dynamic>>> getRegulerMagazine() async {
    Database? db = await instance.database;
    return await db!.rawQuery('''
      SELECT r.magazine_code, m.magazine_name, r.quantity, s.store_name, i.quantity_in_stock
      FROM regulars AS r
      INNER JOIN stores AS s ON r.store_id = s.store_id
      INNER JOIN magazines AS m ON r.magazine_code = m.magazine_code
      INNER JOIN importData AS i ON r.magazine_code = i.magazine_code
      ORDER BY r.magazine_code ASC;
    ''');
  }

  // 入荷チェック用臨時テーブル削除
  static Future<void> dropTable() async {
    Database? db = await instance.database;
    await db!.execute('''
    DROP TABLE importData
  ''');
  }

  // TODO:編集履歴を保存するテーブルをつくるなどしないといけない
}
