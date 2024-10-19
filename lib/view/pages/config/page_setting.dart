import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/constant/messages.dart';
import 'package:flutter_auto_flip/view/components/molecles/setting_tab.dart';
import 'package:flutter_auto_flip/view/components/templates/basic_template.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PageSetting extends HookWidget {
  final TextEditingController controller = TextEditingController();

  PageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> setting = [
      {
        'name': 'ネットワーク',
        'movePage': '/setting/network',
      },
      {
        'name': 'ネットワーク',
        'movePage': '/setting/network',
      }
    ];

    return BasicTemplate(title: '設定', children: [
      Expanded(
          child: Wrap(
              direction: Axis.horizontal, // 水平方向に並べる
              spacing: 8.0, // 要素の間隔を設定
              children: List.generate(setting.length, (index) {
                return SettingTab(
                  name: setting[index]['name']!,
                  movePage: setting[index]['movePage']!,
                );
              }))),
      const Text('ver.${Messages.version}'),
    ]);
  }
}
