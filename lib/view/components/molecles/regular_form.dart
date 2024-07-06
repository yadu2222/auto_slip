import 'package:flutter/material.dart';

import '../molecles/edit_bar.dart';

// TODO: サイズ
class RegularForm extends StatelessWidget {
  const RegularForm({super.key, required this.storeController, required this.magazineNameController, required this.magezineCodeController, required this.quantityController});

  final TextEditingController storeController;
  final TextEditingController magazineNameController;
  final TextEditingController magezineCodeController;
  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [
          EditBarView(controller: storeController, hintText: '店舗名', maxLength: 20, icon: Icons.storefront),
          EditBarView(
            icon: Icons.edit,
            controller: magezineCodeController,
            hintText: '雑誌コード',
            maxLength: 10,
          ),
          EditBarView(
            icon: Icons.menu_book_rounded,
            controller: magazineNameController,
            hintText: '雑誌名',
            maxLength: 20,
          ),
          EditBarView(
            icon: Icons.book_rounded,
            controller: quantityController,
            hintText: '冊数',
            maxLength: 3,
          ),
        ]));
  }
}
