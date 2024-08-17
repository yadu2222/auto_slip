import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/customer_controller.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/molecles/dialog.dart';
import 'package:flutter_auto_flip/view/components/molecles/dropdown_util.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as edit;

// 新しい顧客を追加するページ
class PageAddCustomer extends HookWidget {
  PageAddCustomer({super.key});

  // コントローラー
  final storeNameController = TextEditingController();
  final addressController = TextEditingController();
  final noteController = TextEditingController();

  // dropdownに渡すリスト
  final List<Map<String, dynamic>> methodTypes = [
    // userType
    {'display': '店取', 'value': 2, 'icon': Icons.storefront},
    {'display': '配達', 'value': 1, 'icon': Icons.delivery_dining},
    {'display': '店取伝票', 'value': 3, 'icon': Icons.edit},
  ];
  final List<Map<String, dynamic>> tellTypes = [
    // userType
    {'display': '不要', 'value': 1, 'icon': Icons.phone_disabled_rounded},
    {'display': '要', 'value': 2, 'icon': Icons.phone_enabled},
    {'display': '着信のみ', 'value': 3, 'icon': Icons.phone_callback_rounded},
  ];

  final String title = '顧客登録';
  final String storeNameHint = '顧客名を入力';

  @override
  Widget build(BuildContext context) {
    final CustomerReq customerReq = CustomerReq(context: context);

    final methodType = useState<int>(2);
    final tellType = useState<int>(1);

    void onChangeMehod(int? value) {
      methodType.value = value!;
    }

    void onChangeTellType(int? value) {
      tellType.value = value!;
    }

    void register() {
      // 登録処理
      // customerReq.
      Customer customer = Customer(
        customerName: storeNameController.text,
        address: addressController.text,
        regularType: methodType.value,
        tellType: tellType.value,
        note: noteController.text,
      );
      customerReq.addCustomerHandler(customer).then((value) {
        // 戻る
        // DialogUtil.show(message: '登録に成功しました', context: context);
        GoRouter.of(context).go('/customer');
      });
    }

    return BasicTemplate(title: title, children: [
      // 顧客名
      edit.EditBarView(
        icon: Icons.person,
        hintText: storeNameHint,
        controller: storeNameController,
        inputFormatter: [LengthLimitingTextInputFormatter(18)],
      ),

      const SizedBox(height: 15),

      // 電話番号
      edit.EditBarView(
        icon: Icons.phone,
        hintText: '電話番号',
        controller: addressController,
        inputFormatter: [
          LengthLimitingTextInputFormatter(13),
        ],
      ),

      // 配達タイプ
      DropDownUtil(
        items: methodTypes,
        onChanged: onChangeMehod,
        value: methodType.value,
      ),
      // 電話の処理
      DropDownUtil(
        items: tellTypes,
        onChanged: onChangeTellType,
        value: tellType.value,
      ),

      const SizedBox(height: 25),
      // note
      edit.EditBarView(
        icon: Icons.edit,
        hintText: '備考',
        controller: noteController,
        inputFormatter: [
          LengthLimitingTextInputFormatter(20),
        ],
      ),

      const SizedBox(height: 30),

      BasicButton(
        text: '登録',
        isColor: true,
        onPressed: register,
      )
    ]);
  }
}
