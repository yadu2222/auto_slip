

import 'package:path_provider/path_provider.dart'; // アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

class FileController{

  static Future<void> fileGet() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String path = result.files.single.path!;
      // 選択したファイルのパスを取得して処理を行う

      // TODO:ここでファイルをサーバーに投げる処理を呼び出す
      // List resultData = await RegulerManager.getImportData(path);

      // regulerData = await RegulerManager.getImportData(path);
    } else {
      // ファイルが選択されなかった場合の処理
    }
  }




}