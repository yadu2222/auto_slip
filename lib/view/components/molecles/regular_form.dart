import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/models/magazine_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/list_builder.dart';
import '../molecles/edit_bar.dart';

// TODO: サイズ
class RegularForm extends StatelessWidget {
  const RegularForm(
      {super.key,
      required this.storeController,
      required this.magazineNameController,
      required this.magezineCodeController,
      required this.quantityController,
      required this.newMagazine,
      required this.customerData,
      required this.magazineData,
      required this.changeNewMagazine,
      required this.serachMagazine});

  final TextEditingController storeController;
  final TextEditingController magazineNameController;
  final TextEditingController magezineCodeController;
  final TextEditingController quantityController;
  final bool newMagazine;
  final void Function() changeNewMagazine;
  final void Function(String) serachMagazine;

  final List<Customer> customerData;
  final List<Magazine> magazineData;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [
          EditBarView(
            controller: storeController,
            hintText: '定期先',
            icon: Icons.storefront,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(15)],
          ),
          // ここに検索候補を表示
          customerData.isEmpty ? const SizedBox.shrink() : ListBuilder<Customer>(itemDatas: customerData, listItem: (item) => InkWell(onTap: () {}, child: Text(item.customerName))),

          InkWell(
            onTap: () {},
            child: const Row(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
              Icon(
                Icons.help_outline_rounded,
                size: 20,
              ),
              SizedBox(width: 5),
              Text('新しい定期先ですか？'),
            ]),
          ),
          const SizedBox(height: 20),
          EditBarView(
            icon: Icons.edit,
            controller: magezineCodeController,
            hintText: '雑誌コード',
            inputType: TextInputType.number,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
            onChanged: serachMagazine,
          ),
          magazineData.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 100,
                  width: 400,
                  child: ListBuilder<Magazine>(
                      itemDatas: magazineData,
                      listItem: (item) => InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 12), child: Text(item.magazineName))))),

          newMagazine
              ? EditBarView(
                  search: changeNewMagazine,
                  searchIcon: Icons.close,
                  icon: Icons.menu_book_rounded,
                  controller: magazineNameController,
                  hintText: '雑誌名',
                )
              : InkWell(
                  onTap: () {
                    changeNewMagazine();
                  },
                  child: const Row(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.help_outline_rounded,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text('なにもでてこない？未登録の雑誌ですか？'),
                  ]),
                ),
          const SizedBox(height: 20),
          EditBarView(
            icon: Icons.book_rounded,
            controller: quantityController,
            hintText: '冊数',
            inputType: TextInputType.number,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          ),
        ]));
  }
}
