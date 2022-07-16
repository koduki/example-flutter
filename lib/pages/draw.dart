import 'package:flutter/material.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class DrawPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawPageState();
  }
}

class _DrawPageState extends State<DrawPage> {
  // @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     body: Center(
  //       // child: MySlider(),
  //     ),
  //   );
  // }
  Offset _offset = const Offset(10, 10); //Panドラッグ時のポジション
  Offset _offset2 = const Offset(500, 500); //Panドラッグ時のポジション
  Offset _offset3 = const Offset(300, 10); //Panドラッグ時のポジション

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hwll"),
      ),
      body: Stack(
        children: <Widget>[
          // Panテスト用のウィジェット
          Positioned(
            left: _offset.dx, // 移動の値（x）
            top: _offset.dy, // 移動の値（y）
            child: GestureDetector(
              // ドラッグの移動を更新
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _offset += details.delta;
                });
              },
              child: CustomPaint(
                size: const Size(200, 100),
                painter: HandlerPaint(
                  center: Offset(0, 0),
                ),
              ),
            ),
          ),
          // Scale用のウィジェット
          Positioned(
            left: _offset2.dx, // 移動の値（x）
            top: _offset2.dy, // 移動の値（y）
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              // ドラッグの移動を更新
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _offset2 += details.delta;
                });
              },
              child: CustomPaint(
                size: const Size(200, 200),
                painter: HandlerPaint2(
                  center: const Offset(0, 0),
                ),
              ),
            ),
          ),
          Positioned(
            left: _offset3.dx, // 移動の値（x）
            top: _offset3.dy, // 移動の値（y）
            child: GestureDetector(
              // ドラッグの移動を更新
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _offset3 += details.delta;
                });
              },
              child: CustomPaint(
                size: const Size(200, 100),
                painter: HandlerPaint3(
                  center: const Offset(0, 0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class MySlider extends StatefulWidget {
//   const MySlider();
//   @override
//   MySliderState createState() => MySliderState();
// }

// class MySliderState extends State<MySlider> {
//   Offset center = const Offset(0, 0); // ハンドラの位置
//   final size = const Size(200, 200); // 描画領域のサイズ
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: (DragUpdateDetails details) {
//         var handlerX = details.localPosition.dx;
//         var handlerY = details.localPosition.dy;
//         print(details.localPosition.direction);
//         // handlerX = min(handlerX, size.width); // ハンドラが描画領域を超えないように調整
//         // handlerX = max(0, handlerX); // ハンドラが描画領域を超えないように調整
//         setState(() {
//           center = Offset(handlerX, handlerY); // ハンドラの位置を更新
//         });
//       },
//       onPanStart: (details) => print('onPanStart()'),
//       onPanEnd: (details) => print('onPanEnd()'),
//       child: CustomPaint(
//         size: size,
//         painter: HandlerPaint(
//           center: center,
//         ),
//       ),
//     );
//   }
// }

/// スライダーのハンドラ(青部分)を描画
class HandlerPaint extends CustomPainter {
  HandlerPaint({
    required this.center,
  });
  final Offset center;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(center.dx, center.dy, 200, 100), paint);

    paint.color = Colors.blue;
    canvas.drawCircle(center, 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // ここがfalseだと、onPanUpdate:が発火してもハンドラの描画が更新されない
  }
}

class HandlerPaint2 extends CustomPainter {
  HandlerPaint2({
    required this.center,
  });
  final Offset center;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.green;
    canvas.drawCircle(Offset(100, 100), 100, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // ここがfalseだと、onPanUpdate:が発火してもハンドラの描画が更新されない
  }
}

class HandlerPaint3 extends CustomPainter {
  HandlerPaint3({
    required this.center,
  });
  final Offset center;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(center.dx, center.dy, 200, 100), paint);

    paint.color = Colors.blue;
    canvas.drawCircle(center, 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // ここがfalseだと、onPanUpdate:が発火してもハンドラの描画が更新されない
  }
}
