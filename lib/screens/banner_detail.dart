import 'package:flutter/material.dart';

class BannerDetail extends StatelessWidget {
  const BannerDetail({
    Key? key,
    this.fullBackdropPath,
    this.fullPosterPath,
  }) : super(key: key);

  final fullBackdropPath;
  final fullPosterPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          fullBackdropPath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
        ),
        Positioned(
          child: CustomPaint(
            painter: TrianglePainter(
              strokeColor: Colors.white,
              strokeWidth: 10,
              paintingStyle: PaintingStyle.fill,
            ),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          bottom: 0,
          left: 0,
        ),
        Positioned(
          child: Image.network(
            fullPosterPath,
            fit: BoxFit.cover,
            width: 120,
            height: 180,
          ),
          left: 30,
          bottom: 30,
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({
      this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, y)
      ..lineTo(0, y)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
