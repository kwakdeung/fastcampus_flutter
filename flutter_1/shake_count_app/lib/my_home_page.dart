import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:velocity_x/velocity_x.dart';

import 'red_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  late ShakeDetector detector;

  @override
  void initState() {
    detector = ShakeDetector.autoStart(
        onPhoneShake: () {
          setState(() {
            _counter++;
          });
        },
        shakeThresholdGravity: 1.5);

    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RedBox(),
                Column(
                  children: <Widget>[
                    const RedBox()
                        .box
                        .padding(EdgeInsets.all(30))
                        .color(Colors.blue)
                        .make(),
                    '흔들어서 카운트를 올려보세요.'
                        .text
                        .color(Colors.red)
                        .bold
                        .white
                        .black
                        .size(20)
                        .isIntrinsic
                        .makeCentered()
                        .box
                        .withRounded(value: 50)
                        .color(Colors.green)
                        .height(150)
                        .make()
                        .pSymmetric(h: 20, v: 50),
                    const RedBox(),
                  ],
                ),
                const RedBox(),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        detector.startListening();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        detector.stopListening();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }
}
