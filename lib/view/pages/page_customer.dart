import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/customer_controller.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/alert_dialog.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/molecles/count_icons.dart';
import 'package:flutter_auto_flip/view/components/molecles/dropdown_util.dart';
import 'package:flutter_auto_flip/view/components/molecles/tell_icons.dart';
import 'package:flutter_auto_flip/view/components/organisms/customer_list.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as edit;

class PageCustomer extends HookWidget {
  PageCustomer({super.key});

  final _customerNameController = TextEditingController(); // コントローラー
  final String title = '顧客一覧';
  final String magazineCodeSearch = 'お名前で検索';

  final newCustomerNameController = TextEditingController(); // コントローラー
  final addressController = TextEditingController(); // コントローラー
  final noteController = TextEditingController(); // コントローラー

  @override
  Widget build(BuildContext context) {
    CustomerReq customerReq = CustomerReq(context: context);
    final customers = useState<List<Customer>>([]);
    final delete = useState<bool>(false);

    // 一覧取得
    Future<void> getCustomer() async {
      await customerReq.getCustomerHandler().then((value) {
        customers.value = value;
      });
    }

    // 名前検索
    Future<void> serchName() async {
      if (_customerNameController.text == "") {
        await getCustomer();
        return;
      }
      customerReq.searchCustomerNameHandler(_customerNameController.text).then((value) {
        customers.value = value;
      });
    }

    void editCustomer(Customer customer) {
      // context.push('/regular', extra: {'serachWord': magazine.magazineCode});
      // ダイアログ表示
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return HookBuilder(builder: (BuildContext context) {
              final methodType = useState<int>(customer.regularType);
              final tellType = useState<int>(customer.tellType);

              // dropdownに渡すリスト
              final List<Map<String, dynamic>> methodTypes = [
                // userType
                {'display': '店取', 'value': 2, 'icon': Icons.storefront},
                {'display': '配達', 'value': 1, 'icon': Icons.delivery_dining},
                {'display': '店取伝票', 'value': 3, 'icon': Icons.edit},
                {'display': '図書館', 'value': 4, 'icon': Icons.local_library_rounded},
                {'display': '暁光高校', 'value': 5, 'icon': Icons.edit},
                {'display': '丸長', 'value': 6, 'icon': Icons.local_shipping},
              ];
              final List<Map<String, dynamic>> tellTypes = [
                // userType
                {'display': '不要', 'value': 1, 'icon': Icons.phone_disabled_rounded},
                {'display': '要', 'value': 2, 'icon': Icons.phone_enabled},
                {'display': '着信のみ', 'value': 3, 'icon': Icons.phone_callback_rounded},
              ];

              useEffect(() {
                newCustomerNameController.text = customer.customerName;
                addressController.text = customer.address ?? '';
                noteController.text = customer.note ?? '';

                return null;
              }, []);

              void onChangeMehod(int? value) {
                methodType.value = value!;
              }

              void onChangeTellType(int? value) {
                tellType.value = value!;
              }

              void close() {
                // 初期化しダイアログをとじる
                Navigator.of(context).pop();
              }

              void update() {
                // 更新処理
                Customer updateCustomer = Customer(
                  customerUUID: customer.customerUUID,
                  customerName: newCustomerNameController.text,
                  address: addressController.text,
                  regularType: methodType.value,
                  tellType: tellType.value,
                  note: noteController.text,
                );
                customerReq.updateCustomerHandler(updateCustomer).then((value) {
                  close();
                  getCustomer();
                });
              }

              return AleatDialogUtil(
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
                      icon: Icons.person,
                      hintText: '名前',
                      controller: newCustomerNameController,
                    ),
                    // 電話番号
                    edit.EditBarView(
                      width: 300,
                      icon: Icons.phone,
                      hintText: '電話番号',
                      controller: addressController,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(13),
                      ],
                    ),

                    // 配達タイプ
                    DropDownUtil(
                      width: 290,
                      height: 45,
                      items: methodTypes,
                      onChanged: onChangeMehod,
                      value: methodType.value,
                    ),
                    const SizedBox(height: 10),
                    // 電話の処理
                    DropDownUtil(
                      width: 290,
                      height: 45,
                      items: tellTypes,
                      onChanged: onChangeTellType,
                      value: tellType.value,
                    ),
                    const SizedBox(height: 10),
                    edit.EditBarView(
                      width: 300,
                      icon: Icons.edit,
                      hintText: '備考',
                      controller: noteController,
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

    void deliteCustomer(Customer customer) {
      // 削除処理

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
              content: Text("「${customer.customerName}」を削除しますか？"),
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
                    customerReq.deliteCustomerHandler(customer.customerUUID).then((value) {
                      getCustomer();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    void onTapCustomer(Customer customer) {
      delete.value ? deliteCustomer(customer) : editCustomer(customer);
    }

    useEffect(() {
      getCustomer();
      return null;
    }, []);

    void switchDelete() {
      delete.value = !delete.value;
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
              context.push('/customer/add').then((value) => getCustomer());
            },
            icon: const Icon(Icons.add, size: 30),
          ),
        ]),
        children: [
          // 検索バー
          // 名前で検索
          edit.EditBarView(
            icon: Icons.person,
            hintText: magazineCodeSearch,
            controller: _customerNameController,
            search: serchName,
          ),
          // タイプでソート

          // アイコンの説明
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CountIcons(book: false), TellIcons()],
          ),
          const SizedBox(height: 10),

          CustomerList.vertical(customerData: customers.value, onTap: onTapCustomer)
        ]);
  }
}
