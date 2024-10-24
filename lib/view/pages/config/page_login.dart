import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/service/login_service.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';

import 'package:flutter_auto_flip/view/components/molecles/edit_bar.dart';
import 'package:flutter_auto_flip/view/components/templates/basic_template.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageLogin extends HookWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  PageLogin({super.key});
  @override
  Widget build(BuildContext context) {
    // ログイン情報を保存
    Future<void> setIp() async {
      final token = await LoginService.login(idController.text, passwordController.text);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('id', idController.text);
      prefs.setString('password', passwordController.text);
      prefs.setString('token', token);
    }

    useEffect(() {
      // shared_preferencesから指定された情報を取得
      Future<String> getPreference(TextEditingController controller, String name) async {
        final prefs = await SharedPreferences.getInstance();
        final result = prefs.getString(name);
        controller.text = result ?? ''; // コントローラにセット
        return result ?? '';
      }

      getPreference(idController, 'id');
      getPreference(passwordController, 'password');
      return null;
    }, []);

    return BasicTemplate(title: 'ログイン', children: [
      const Text('ログイン情報を入力してください'),
      EditBarView(controller: idController, hintText: 'id', icon: Icons.supervised_user_circle_rounded),
      EditBarView(controller: passwordController, hintText: 'password', icon: Icons.password),
      BasicButton(text: 'ログイン', isColor: false, onPressed: setIp),
      // Spacer(),
      // Text('セキュリティの都合上定期的にログインすることをおすすめします')
    ]);
  }
}
