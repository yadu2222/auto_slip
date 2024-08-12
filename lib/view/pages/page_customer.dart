

import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/customer_controller.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/view/components/organisms/customer_list.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
// model

// api

// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as edit;

class PageCustomer extends HookWidget {
  PageCustomer({super.key});

  final _customerNameController = TextEditingController(); // コントローラー
  final String title = '顧客一覧';
  final String magazineCodeSearch = 'お名前で検索';

  @override
  Widget build(BuildContext context) {
    CustomerReq customerReq = CustomerReq(context: context);
    final customers = useState<List<Customer>>([]);

    // 一覧取得
    Future<void> getCustomer() async {
      await customerReq.getCustomerHandler().then((value) {
        customers.value = value;
      });
    }

    // 雑誌コード検索
    Future<void> serchMagazineCode() async {
      if (_customerNameController.text == "") {
        await getCustomer();
        return;
      }
      // customerReq.searchMagazineCodeHandler(_customerNameController.text).then((value) {
      //   customers.value = value;
      // });
    }

    void onTap(Customer customer) {
      // context.push('/regular', extra: {'serachWord': magazine.magazineCode});
      // ダイアログ表示
    }

    useEffect(() {
      getCustomer();
      return null;
    }, []);

    return BasicTemplate(
        title: title,
        floatingActionButton: IconButton(
          onPressed: () {
            // 追加画面に遷移
            context.go('/add');
          },
          icon: const Icon(Icons.add, size: 30),
        ),
        children: [
          // 検索バー
          // 名前で検索
          edit.EditBarView(
            icon: Icons.person,
            hintText: magazineCodeSearch,
            controller: _customerNameController,
            search: serchMagazineCode,
          ),
          // タイプでソート

          CustomerList.vertical(customerData: customers.value, onTap: onTap)
        ]);
  }
}
