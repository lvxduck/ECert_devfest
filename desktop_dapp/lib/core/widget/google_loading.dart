import 'package:flutter/material.dart';
import 'dart:math' as math;

class GoogleLoading extends StatefulWidget {
  final List<Color> googleColors = <Color>[
    const Color(0xffea4335),
    const Color(0xff4285f4),
    const Color(0xfffbbc05),
    const Color(0xff34a853),
  ];
  final double radius;
  final double strokeWidth;

  GoogleLoading({Key? key, this.strokeWidth = 4, this.radius = 40}) : super(key: key);

  @override
  _GoogleLoadingState createState() => _GoogleLoadingState();
}

class _GoogleLoadingState extends State<GoogleLoading> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(seconds: 8), vsync: this);
    animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: animationController.value * 6 * math.pi,
            child: CustomPaint(
              painter: LoadingPainter(
                value: animationController.value * 4 % 1,
                color: getColor(animationController.value),
                strokeWidth: widget.strokeWidth,
              ),
              size: Size(widget.radius * 2, widget.radius * 2),
            ),
          );
        },
      ),
    );
  }

  Color getColor(double value) {
    final int index = (value * 4).toInt();
    final ColorTween x =
        ColorTween(begin: widget.googleColors[index], end: widget.googleColors[index > 2 ? 0 : index + 1]);
    return x.transform(Curves.easeOutQuint.transform(value * 4 % 1)) ?? widget.googleColors[0];
  }
}

class LoadingPainter extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;

  LoadingPainter({required this.value, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcRect =
        Rect.fromCircle(center: Offset(size.height / 2, size.width / 2), radius: size.height / 2 - strokeWidth / 2);
    final Paint progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final double curveValue = Curves.easeInOut.transform(value);
    double sweepAngle;
    double startAngle;
    if (value <= 0.5) {
      sweepAngle = degToRad(360.0 * curveValue * 2);
      startAngle = sweepAngle / 4;
      canvas.drawArc(arcRect, startAngle, sweepAngle - startAngle, false, progressPaint);
    } else {
      startAngle = 3 * math.pi * (curveValue - 0.5) + math.pi / 2;
      sweepAngle = degToRad(360.0);
    }
    canvas.drawArc(arcRect, startAngle, sweepAngle - startAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double degToRad(num deg) => deg * (math.pi / 180.0);

  num radToDeg(num rad) => rad * (180.0 / math.pi);
}
