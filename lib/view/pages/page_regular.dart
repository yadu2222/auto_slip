import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_flip/apis/controller/customer_controller.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/models/magazine_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/atoms/list_builder.dart';
import 'package:flutter_auto_flip/view/components/organisms/add_regular_dialog.dart';
import 'package:flutter_auto_flip/view/components/organisms/regular_customer_list.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_auto_flip/view/components/molecles/count_icons.dart';
import 'package:flutter_auto_flip/view/components/templates/basic_template.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../components/molecles/edit_bar.dart' as edit;
import 'package:flutter_auto_flip/apis/controller/regular_controller.dart';
// mode;
import '../../models/load_regular_model.dart';
import '../components/organisms/regular_list.dart';

class PageRegularMagazine extends HookWidget {
  final TextEditingController userNameController = TextEditingController(); // 編集者の名前
  final TextEditingController storeNameController = TextEditingController(); // 店舗名
  final TextEditingController magazineCodeController = TextEditingController(); // 雑誌コード
  final TextEditingController magazinerNameController = TextEditingController(); // 顧客名
  // 新規登録
  final TextEditingController newStoreNameController = TextEditingController(); // 新しい店舗名
  final TextEditingController newCountController = TextEditingController(); // 新しい店舗名

  PageRegularMagazine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RegularReq regularReq = RegularReq(context: context);
    CustomerReq customerReq = CustomerReq(context: context);
    final regularList = useState<List<LoadRegular>>([]);
    final view = useState<Widget>(const SizedBox());

    // タップした雑誌で定期を追加
    void addRegularByMagazine(Magazine magazine) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return HookBuilder(
            builder: (BuildContext context) {
              final customers = useState<List<Customer>>([]);
              final selectCustomer = useState<Customer?>(null);

              // 定期先検索処理
              Future<void> searchStoreName(String name) async {
                final result = await customerReq.searchCustomerNameHandler(name);
                customers.value = result;
              }

              void close() {
                // 初期化しダイアログをとじる
                newCountController.clear();
                newStoreNameController.clear();
                customers.value = [];
                Navigator.of(context).pop();
              }

              void choise(Customer customer) {
                selectCustomer.value = customer;
                customers.value = [];

                newStoreNameController.text = customer.customerName;
              }

              void register() {}

              return AddRegularDialog(
                magazine: magazine,
                close: close,
                newStoreNameController: newStoreNameController,
                newCountController: newCountController,
                onChanged: searchStoreName,
                customers: customers.value,
                choise: choise,
                register: register,
              );
            },
          );
        },
      );
    }

    // 定期一覧取得
    Future<void> getRegular() async {
      await regularReq.getMagazineRegularHandler().then((value) {
        regularList.value = value;
        view.value = RegularList(
          regularList: regularList.value,
          onTap: (customer) => print(customer),
          magazineTap: addRegularByMagazine,
        );
      });
    }

    // 顧客名で定期情報を取得
    Future<void> getRegularByCustomerName() async {
      if (storeNameController.text == "") {
        getRegular();
        return;
      }

      await regularReq.getMagazineRegularByCustomerNameHandler(storeNameController.text).then((value) {
        regularList.value = value;
        view.value = RegularCustomerList(
          regularList: regularList.value,
          onTap: (customer) => print(customer),
        );
      });
    }

    // 雑誌名で定期情報を取得
    Future<void> getRegularByMagazineName() async {
      if (magazinerNameController.text == "") {
        getRegular();
        return;
      }

      await regularReq.getMagazineRegularByMagazineNameHandler(magazinerNameController.text).then((value) {
        regularList.value = value;
        view.value = RegularList(
          regularList: regularList.value,
          onTap: (customer) => print(customer),
          magazineTap: (magazine) => print(magazine),
        );
      });
    }

    // 雑誌コードで定期情報を取得
    Future<void> getRegularByMagazineCode() async {
      if (magazineCodeController.text == "") {
        getRegular();
        return;
      }

      await regularReq.getMagazineRegularByMagazineCodeHandler(magazineCodeController.text).then((value) {
        regularList.value = value;
        view.value = RegularList(
          regularList: regularList.value,
          onTap: (customer) => print(customer),
          magazineTap: (magazine) => print(magazine),
        );
      });
    }

    useEffect(() {
      getRegular();
      return null;
    }, []);

    return BasicTemplate(
      title: '定期',
      floatingActionButton: IconButton(
        onPressed: () {
          // 追加画面に遷移
          context.go('/regular/add');
        },
        icon: const Icon(Icons.add, size: 30),
      ),
      children: [
        const SizedBox(height: 30),
        // edit.EditBarView(
        //   // 名前の入力
        //   controller: userNameController,
        //   hintText: 'あなたの名前はなんですか',
        //   icon: Icons.edit,
        // ),
        edit.EditBarView(
          icon: Icons.local_offer,
          hintText: '雑誌コード',
          controller: magazineCodeController,
          search: getRegularByMagazineCode,
          inputType: TextInputType.number,
          inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
        ),
        edit.EditBarView(
          icon: Icons.import_contacts,
          hintText: '雑誌名',
          controller: magazinerNameController,
          search: getRegularByMagazineName,
        ),
        edit.EditBarView(
          icon: Icons.person,
          hintText: '顧客名',
          controller: storeNameController,
          search: getRegularByCustomerName,
        ),
        const CountIcons(
          book: false,
        ),
        const SizedBox(height: 10),
        view.value,
      ],
    );
  }
}
