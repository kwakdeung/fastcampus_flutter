// v2: add Gesture detector
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perspective',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key); // changed

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = 0; // x축 => + 일 때 위, - 일 때 아래로 기울어짐
  double y = 1; // y축 => - 일 때 좌, + 일 때 우로 기울어짐
  double z = 0; // z축 => + 일 때 시계방향, - 일 때 반시계방향

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4(
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
          )
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          // 1 0 0 0 - x축의 방향과 크기를 유지함
          // 0 1 0 0 - y축의 방향과 크기를 유지함
          // 0 0 1 0 - z축의 방향과 크기를 유지함
          // 0 0 0 1 - 동차 좌표, 3D 변환(회전, 이동, 크기 변경)을 위한 계산에서 중요한 역할
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                y = y - details.delta.dx / 100;
                x = x + details.delta.dy / 100;
              });
            },
            child: Container(
              color: Colors.red,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
