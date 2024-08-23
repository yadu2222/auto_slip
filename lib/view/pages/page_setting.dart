import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/constant/messages.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';

import 'package:flutter_auto_flip/view/components/molecles/edit_bar.dart';
import 'package:flutter_auto_flip/view/components/templates/basic_template.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageSetting extends HookWidget {
  final TextEditingController controller = TextEditingController();

  PageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    // ipアドレスを保存
    Future<void> setIp() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('ip', controller.text);
    }

    useEffect(() {
      // ipアドレスを取得
      Future<String> getIp() async {
        final prefs = await SharedPreferences.getInstance();
        final ip = prefs.getString('ip');
        controller.text = ip ?? '';
        return ip ?? '';
      }

      getIp();
      return null;
    }, []);

    return BasicTemplate(title: '設定', children: [
      const Text('サーバーのipアドレスを入力してください'),
      EditBarView(controller: controller, hintText: 'ip', icon: Icons.computer),
      const Text('あまりさわる場所ではないです'),
      BasicButton(text: '確定', isColor: false, onPressed: setIp),
      const Spacer(),
      const Text('ver.${Messages.version}'),
    ]);
  }
}
