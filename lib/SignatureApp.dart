import 'package:flutter/material.dart';

/// 一个签名的应用

// void main() =>runApp(MaterialApp(home:SignatureApp()));

class SignatureApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(body: Signature(title: "涂鸦",));

}
class Signature extends StatefulWidget {
  const Signature({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  SignatureState createState() => SignatureState();
}

class SignatureState extends State<Signature>{
  List<Offset?> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox? referenceBox = context.findRenderObject() as RenderBox;
          Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),

      child: CustomPaint(
        painter: SignaturePainter(_points),
        size: Size.infinite,
      ),
    );
  }


}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);
  final List<Offset?> points;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}