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
  var diagrams = [
    RectDiagram(
        color: Colors.yellow.shade200,
        size: const Size(200, 100),
        position: const Offset(10, 10)),
    RectDiagram(
        color: Colors.lightBlue.shade200,
        size: const Size(320, 320),
        position: const Offset(300, 10)),
    CircleDiagram(
        color: Colors.lightGreen.shade200,
        size: const Size(200, 200),
        position: const Offset(400, 400)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Draw"),
      ),
      body: Stack(children: diagrams.map((x) => x.build(this)).toList()),
    );
  }
}

abstract class Diagram {
  Diagram({
    required this.position,
    required this.size,
    required this.color,
  });
  Offset position;
  Size size;
  Color color;

  Widget build(State state);
}

class RectDiagram extends Diagram {
  RectDiagram(
      {required super.position, required super.size, required super.color});

  @override
  Widget build(State state) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          state.setState(() {
            print("update: " + position.toString());

            position += details.delta;
          });
        },
        child: CustomPaint(
          size: size,
          painter: ReactPainter(
            size: size,
            color: color,
          ),
        ),
      ),
    );
  }
}

class ReactPainter extends CustomPainter {
  ReactPainter({
    required this.size,
    required this.color,
  });
  final Offset offset = const Offset(0, 0);
  final Size size;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    canvas.drawRect(
        Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height), paint);

    paint.color = Colors.blue;
    canvas.drawCircle(offset, 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CircleDiagram extends Diagram {
  CircleDiagram(
      {required super.position, required super.size, required super.color});

  @override
  Widget build(State state) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          state.setState(() {
            print("update: " + position.toString());

            position += details.delta;
          });
        },
        child: CustomPaint(
          size: size,
          painter: CirclePainter(
            radius: size.width / 2,
            color: color,
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    required this.radius,
    required this.color,
  });
  final Color color;
  final double radius;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = color;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
