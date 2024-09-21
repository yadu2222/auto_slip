import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/components/atoms/alert_dialog.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// model
import 'package:flutter_auto_flip/models/magazine_model.dart';
// api
import 'package:flutter_auto_flip/apis/controller/magazine_controller.dart';
// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as edit;
import 'package:flutter_auto_flip/view/components/organisms/magazine_list.dart';

class PageMagazine extends HookWidget {
  PageMagazine({super.key});

  // コントローラー
  final _magazineController = TextEditingController();
  final _magazineNameController = TextEditingController();
  final _newMagazineController = TextEditingController();
  final _newMagazineNameController = TextEditingController();

  // どちらで検索しているかを判別する変数

  final String title = '雑誌一覧';
  final String magazineCodeSearch = '雑誌コードで検索';
  final String magazineNameSearch = '誌名で検索';

  @override
  Widget build(BuildContext context) {
    MagazineReq magazineReq = MagazineReq(context: context);
    final magazines = useState<List<Magazine>>([]);
    final delete = useState<bool>(false);

    // 一覧取得
    Future<void> getMagazine() async {
      await magazineReq.getMagazineHandler().then((value) {
        magazines.value = value;
      });
    }

    // 雑誌名検索
    Future<void> serchMagazineName() async {
      if (_magazineNameController.text == "") {
        await getMagazine();
        return;
      }
      magazineReq.searchMagazineNameHandler(_magazineNameController.text).then((value) {
        magazines.value = value;
      });
    }

    // 雑誌コード検索
    Future<void> serchMagazineCode() async {
      if (_magazineController.text == "") {
        await getMagazine();
        return;
      }
      magazineReq.searchMagazineCodeHandler(_magazineController.text).then((value) {
        magazines.value = value;
      });
    }

    useEffect(() {
      getMagazine();
      return null;
    }, []);

    void switchDelete() {
      delete.value = !delete.value;
    }

    void editMagazine(Magazine magazine) {
      // context.push('/regular', extra: {'serachWord': magazine.magazineCode});
      // ダイアログ表示
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return HookBuilder(builder: (BuildContext context) {
              useEffect(() {
                _newMagazineController.text = magazine.magazineCode;
                _newMagazineNameController.text = magazine.magazineName;

                return null;
              }, []);

              void close() {
                // 初期化しダイアログをとじる
                Navigator.of(context).pop();
              }

              void update() {
                // 更新処理
                Magazine newMagazine = Magazine(
                  magazineCode: _newMagazineController.text,
                  magazineName: _newMagazineNameController.text,
                );
                magazineReq.updateMagazineHandler(newMagazine, magazine.magazineCode).then((value) {
                  getMagazine();
                  close();
                });
              }

              return AleatDialogUtil(
                  height: 300,
                  contents: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          '編集',
                        ),
                        const SizedBox(height: 10),

                        edit.EditBarView(
                          width: 300,
                          icon: Icons.local_offer,
                          hintText: '雑誌コード',
                          controller: _newMagazineController,
                        ),

                        // 電話番号
                        edit.EditBarView(
                          width: 300,
                          icon: Icons.import_contacts,
                          hintText: '雑誌名',
                          controller: _newMagazineNameController,
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(13),
                          ],
                        ),

                        const Spacer(),

                        // 編集、やめるボタン
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BasicButton(text: 'とじる', isColor: true, onPressed: close),
                            const SizedBox(width: 10),
                            BasicButton(text: '編集完了', isColor: false, onPressed: update),
                          ],
                        )
                      ],
                    ),
                  ));
            });
          });
    }

    void deleteMagazine(Magazine magazine) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                // dialogの角丸
                borderRadius: BorderRadius.circular(1.0),
              ),
              title: const Text("削除"),
              content: Text("「${magazine.magazineName}」を削除しますか？"),
              actions: <Widget>[
                TextButton(
                  child: const Text('いいえ'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('削除'),
                  onPressed: () {
                    magazineReq.deleteMagazineHandler(magazine.magazineCode).then((value) {
                      getMagazine();
                    });

                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    void onTapMagazine(Magazine magazine) {
      delete.value ? deleteMagazine(magazine) : editMagazine(magazine);
    }

    return BasicTemplate(
        title: title,
        floatingActionButton: Row(children: [
          // ごみばこ
          IconButton(
            onPressed: () {
              switchDelete();
            },
            icon: Icon(
              Icons.delete,
              size: 30,
              color: delete.value ? Colors.red : null,
            ),
          ),
          // 追加
          IconButton(
            onPressed: () {
              // 追加画面に遷移
              context.go('/magazine/add');
            },
            icon: const Icon(Icons.add, size: 30),
          ),
        ]),
        children: [
          // 検索バー
          // 雑誌コード
          edit.EditBarView(
            icon: Icons.local_offer,
            hintText: magazineCodeSearch,
            controller: _magazineController,
            search: serchMagazineCode,
            inputType: TextInputType.number,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
          ),
          // 雑誌名
          edit.EditBarView(
            icon: Icons.import_contacts,
            hintText: magazineNameSearch,
            controller: _magazineNameController,
            search: serchMagazineName,
          ),
          MagazineList(magazines: magazines.value, onRefresh: getMagazine, onTap: onTapMagazine)
        ]);
  }
}
