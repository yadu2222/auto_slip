import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/templates/basic_template.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PageInvoice extends HookWidget {
  const PageInvoice({super.key});

  @override
  Widget build(BuildContext context) {


    

    return const BasicTemplate(title: '請求書をつくろう', children: [
      BasicButton(text: '日付を選択してね', isColor: false)
      
    ]);
  }
}
