import 'dart:math';

import 'package:divination/calc.dart';
import 'package:divination/coin.dart';
import 'package:divination/gua.dart';
import 'package:divination/util.dart';
import 'package:flip/flip.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'constant.dart';
import 'layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '周易卜卦',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/calc': (context) => const CalcPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 正在摇卦
  bool shaking = false;
  // 第几次
  int timeIndex = 0;

  List<int> guaList = [-1, -1, -1, -1, -1, -1];

  List<FlipController> coinList = [
    FlipController(),
    FlipController(),
    FlipController(),
  ];

  flipCoin() {
    if (!shaking) {
      var gua = 0;
      for (var item in coinList) {
        var value = Random().nextInt(81 * 64) % 2;
        item.isFront = value == 1;
        gua += value;
      }
      guaList[timeIndex] = gua;
      Log.info('guaList $guaList');
      timeIndex += 1;
      setState(() {});
      return;
    }
    for (var item in coinList) {
      item.flip();
    }
    Future.delayed(Constant.FLIP_SPEED, () {
      flipCoin();
    });
  }

  startDivination() {
    if (timeIndex == 6) return;
    setState(() {
      shaking = true;
      flipCoin();
    });
    Future.delayed(Constant.SHAKING_DURATION, () {
      setState(() {
        shaking = false;
      });
    });
  }

  restart() {
    setState(() {
      timeIndex = 0;
      guaList = [-1, -1, -1, -1, -1, -1];
      for (var item in coinList) {
        item.isFront = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      Column(
        children: [
          SizedBox(
            height: 120,
            width: 360,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
              children: coinList
                  .map((e) => Coin(
                        controller: e,
                      ))
                  .toList(),
            ),
          ),
          timeIndex == 6
              ? Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: GFButton(
                        text: '再起一卦',
                        size: GFSize.LARGE,
                        shape: GFButtonShape.pills,
                        color: Colors.black,
                        blockButton: true,
                        onPressed: () {
                          restart();
                        },
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 4,
                      child: GFButton(
                        text: '解卦',
                        size: GFSize.LARGE,
                        shape: GFButtonShape.pills,
                        color: Colors.red.shade900,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalcPage(values: guaList),
                              ));
                        },
                      ),
                    ),
                  ],
                )
              : GFButton(
                  text: '摇卦',
                  size: GFSize.LARGE,
                  shape: GFButtonShape.pills,
                  color: Colors.red.shade900,
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  onPressed: !shaking
                      ? () {
                          startDivination();
                        }
                      : null,
                ),
          GFCard(
            title: const GFListTile(
              padding: EdgeInsets.zero,
              title: Center(
                child: Text(
                  '请集中精力，默想所占之事',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            color: Colors.amber[100],
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 80),
            content: Gua(
              values: guaList,
            ),
          ),
        ],
      ),
    );
  }
}
