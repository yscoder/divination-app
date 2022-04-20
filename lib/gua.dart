import 'package:divination/constant.dart';
import 'package:flutter/material.dart';

class Gua extends StatelessWidget {
  const Gua({Key? key, required this.values}) : super(key: key);

  final List<int> values;

  @override
  Widget build(BuildContext context) {
    var columns = <Widget>[];
    var len = values.length;
    for(var index = len - 1; index >= 0; index--) {
      // 2： ——，1：- -，0：——O，3：- -X
      var value = values[index];
      var isYang = value == 2 || value == 0;
      // 阳九阴六
      var num = isYang ? '九' : '六';
      var yaoOrder = value >= 0 ? '${Constant.YAO_ORDER[index].replaceAll('#', num)}:' : ' ';

      var children = <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            yaoOrder,
            style: TextStyle(
              color: Colors.yellow[900],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value >= 0 ? Constant.YAO_NAME[value] : ' ',
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ];
      if (value == 1 || value == 3) {
        children.add(Expanded(
          flex: 3,
          child: Container(
            color: Colors.black,
            height: 30,
          ),
        ));
        children.add(const Spacer(
          flex: 1,
        ));
        children.add(Expanded(
          flex: 3,
          child: Container(
            color: Colors.black,
            height: 30,
          ),
        ));
      }
      if (isYang) {
        children.add(Expanded(
          flex: 7,
          child: Container(
            color: Colors.red[900],
            height: 30,
          ),
        ));
      }

      if (value == 0) {
        children.add(Expanded(
          flex: 1,
          child: Icon(
            Icons.circle_outlined,
            color: Colors.red[900],
          ),
        ));
      } else if (value == 3) {
        children.add(const Expanded(
          flex: 1,
          child: Icon(Icons.close_outlined),
        ));
      } else {
        children.add(const Spacer(
          flex: 1,
        ));
      }

      columns.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 30,
        child: Flex(
          direction: Axis.horizontal,
          children: children,
        ),
      ));
    }

    return Column(
      children: columns,
    );
  }
}
