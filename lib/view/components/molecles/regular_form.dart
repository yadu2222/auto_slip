import 'package:flutter/material.dart';

import '../atoms/edit_form.dart';

// TODO: サイズ
class RegularForm extends StatelessWidget {
  const RegularForm({super.key,required this.storeController, required this.magazineNameController, required this.magezineCodeController, required this.quantityController});

  final TextEditingController storeController;
  final TextEditingController magazineNameController;
  final TextEditingController magezineCodeController;
  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        alignment: Alignment.center,
        child: Column(children: [
          EditForm(controller: storeController, hintText: '店舗名', maxLength: 20, width: 0.9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 等間隔に配置
            children: [
              EditForm(
                width: 0.225,
                controller: magazineNameController,
                hintText: '雑誌名',
                maxLength: 20,
              ),
              EditForm(
                width: 0.225,
                controller: magezineCodeController,
                hintText: '雑誌コード',
                maxLength: 10,
              ),
              EditForm(
                width: 0.05,
                controller: quantityController,
                hintText: '冊数',
                maxLength: 3,
              ),
            ],
          )
        ]));
  }
}
