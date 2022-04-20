import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class PageLayout extends StatelessWidget {
  const PageLayout(this.body, {Key? key}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '周易卜卦',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        // actions: [GFButton(
        //   text: 'hello', onPressed: () {  },
        // ),]
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          constraints: const BoxConstraints( maxWidth: 480,),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: body,
        ),
      ),
    );
  }
}