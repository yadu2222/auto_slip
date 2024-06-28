

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class MoleculesWidget extends StatelessWidget {
  const MoleculesWidget({
    super.key,
  });
}

class editFormWidget extends MoleculesWidget {
  // const editForm({
  //   super.key,
  //   // super.screenSizeWidth,
  //   // super.screenSizeHeight,

  // })

  // 入力フォーム
  Widget editForm(double width, double height, TextEditingController controller, String hintText, int maxLength) {
    return Container(
        // width: screenSizeWidth * width,
        // height: screenSizeHeight * height,
        alignment: Alignment.center,
        child: TextField(
          enabled: true,
          maxLength: maxLength, // 入力文字数
          maxLines: 1,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ));
  }

  Widget dispListView(List<String> dispList, Widget listCard, Function reduceFunction, {String? key_1, String? key_2, String? key_3}) {
    return

        // SizedBox(
        //     width: screenSizeWidth * width,
        //     height: height * 5,
        //     child:

        ListView.builder(
            itemCount: dispList.length,
            itemBuilder: (context, index) {
              return dispListCard(
                index,

                dispList,
                reduceButtun(reduceFunction),
                // null でも渡される
                key_1: key_1,
                key_2: key_2,
                key_3: key_3,
              );
            });
    // );
  }

  Widget reduceButtun(Function reduceFunction) {
    return IconButton(
        onPressed: () {
          reduceFunction();
        },
        icon: const Icon(
          Icons.horizontal_rule,
          color: Colors.black,
          size: 20,
        ));
  }

  Widget dispListCard(int index, List<String> dispList, Widget actionBottun, {String? key_1, String? key_2, String? key_3}) {
    return Card(
        elevation: 0,
        child: Row(
          children: [
            // 動作のボタン
            actionBottun,
            // 情報の表示
            key_1 != null ? dispText(dispList, index, key_1, 0.225) : const SizedBox.shrink(),
            key_2 != null ? dispText(dispList, index, key_2, 0.225) : const SizedBox.shrink(),
            key_3 != null ? dispText(dispList, index, key_3, 0.15) : const SizedBox.shrink(),
          ],
        ));
  }

  Widget dispText(List dispList, int index, String key, double width) {
    return Container(alignment: Alignment.center, child: Text(dispList[index][key]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
