import 'package:divination/constant.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'layout.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({Key? key, this.values = const []}) : super(key: key);

  final List<int> values;

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  // 卦值
  List<int> lineValues = [];
  // 变卦索引
  List<int> changed = [];
  String title = '';
  String content = '';

  @override
  initState() {
    calcResult();
    super.initState();
  }

  void calcResult() {
    for (var i = 0; i < widget.values.length; i++) {
      var value = widget.values[i];
      if (value == 0 || value == 3) {
        changed.add(i + 1);
        // 变卦值转为本卦值
        lineValues.add(value == 0 ? 2 : 1);
      } else {
        lineValues.add(value);
      }
    }

    // 计算卦的索引
    int upGuaIndex = (lineValues[5] > 1 ? 4 : 0) + (lineValues[4] > 1 ? 2 : 0) + (lineValues[3] > 1 ? 1 : 0);
    int downGuaIndex = (lineValues[2] > 1 ? 4 : 0) + (lineValues[1] > 1 ? 2 : 0) + (lineValues[0] > 1 ? 1 : 0);
    int guaIndex = Constant.GUA_MAP[upGuaIndex][downGuaIndex];

    // 卦的结果： 第X卦 X卦 XX卦 上X下X X上X下
    String guaName = Constant.GUA_NAME[guaIndex - 1];
    String guaName2 = '';
    if (upGuaIndex == downGuaIndex) {
      // 上下卦相同，格式 [卦名]为[卦象] eg. 乾为天
      guaName2 = '${Constant.GUA_DICT[upGuaIndex]}为${Constant.GUA_IMAGE[upGuaIndex]}';
    } else {
      // 格式 [上卦象][下卦象][卦名] eg. 火山旅
      guaName2 = Constant.GUA_IMAGE[upGuaIndex] + Constant.GUA_IMAGE[downGuaIndex] + guaName;
    }

    String desc = '${Constant.GUA_DICT[upGuaIndex]}上${Constant.GUA_DICT[downGuaIndex]}下';
    String desc2 = '上${Constant.GUA_DICT[upGuaIndex]}下${Constant.GUA_DICT[downGuaIndex]}';

    String changeDesc = changed.isEmpty ? '无变爻' : '变爻：${changed.join('，')}';

    title = '第 $guaIndex 卦 $guaName卦（$guaName2），$changeDesc';
    content = '周易第$guaIndex卦_$guaName卦_${guaName2}_${desc}_$desc2';
  }

  void _launchURL() async {
    var url = 'https://www.baidu.com/s?wd=title:($content)';
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      GFAlert(
        title: title,
        content: content,
        type: GFAlertType.fullWidth,
        bottombar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GFButton(
              onPressed: () {
                // 跳转浏览器
                _launchURL();
              },
              shape: GFButtonShape.pills,
              icon: const Icon(
                Icons.keyboard_arrow_right,
                color: GFColors.WHITE,
              ),
              position: GFPosition.end,
              color: Colors.black,
              text: '看详解',
            ),
          ],
        ),
      ),
    );
  }
}
