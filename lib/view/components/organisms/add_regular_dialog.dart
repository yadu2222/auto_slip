import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/models/magazine_model.dart';
import '../molecles/edit_bar.dart' as edit;
import '../atoms/alert_dialog.dart';
import 'package:flutter_auto_flip/view/components/atoms/list_builder.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';

class AddRegularDialog extends StatelessWidget {
  const AddRegularDialog(
      {super.key,
      required this.magazine,
      required this.close,
      required this.newStoreNameController,
      required this.newCountController,
      required this.onChanged,
      required this.customers,
      required this.choise,
      required this.register});

  final Magazine magazine; // 選択中の雑誌
  final TextEditingController newStoreNameController;
  final TextEditingController newCountController;
  final List<Customer> customers; // 検索結果
  final void Function(String) onChanged; // 入力に合わせて検索処理
  final void Function(Customer) choise; // 検索結果から顧客を選択
  final void Function() register; // 登録
  final void Function() close; // とじる

  @override
  Widget build(BuildContext context) {
    return AleatDialogUtil(
      contents: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            '定期の追加',
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                magazine.magazineCode,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
              Text(
                magazine.magazineName,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          edit.EditBarView(
            controller: newStoreNameController,
            hintText: '新しい定期先',
            icon: Icons.person,
            width: 300,
            onChanged: onChanged,
          ),
          customers.isEmpty
              ? const SizedBox.shrink() // 検索結果がない場合は表示しない
              : ListBuilder<Customer>(
                  itemDatas: customers,
                  listItem: (item) => InkWell(
                    onTap: () => choise(item),
                    child: Text(item.customerName),
                  ),
                ),
          edit.EditBarView(
            controller: newCountController,
            hintText: '冊数',
            icon: Icons.book_rounded,
            width: 300,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
          ),
          customers.isEmpty ? const Spacer() : const SizedBox.shrink(), // 検索結果がなければスペース

          // ボタン
          Row(
            children: [
              BasicButton(text: 'とじる', isColor: false, width: 150, onPressed: close),
              const SizedBox(width: 10),
              BasicButton(
                text: '登録',
                isColor: true,
                width: 150,
                onPressed: register,
              ),
            ],
          )
        ],
      ),
    );
  }
}
