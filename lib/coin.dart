import 'package:flip/flip.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class Coin extends StatelessWidget {
   const Coin({Key? key, required this.controller })
      : super(key: key);

  final FlipController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flip(
        controller: controller,
        flipDirection: Axis.horizontal,
        flipDuration: Constant.FLIP_SPEED,
        firstChild: Image.asset(
          'images/1.png',
          height: 80,
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
        ),
        secondChild: Image.asset(
          'images/0.png',
          height: 80,
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}