import 'package:flutter/material.dart';

class TrapezoidalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final Color color;

  const TrapezoidalAppBar({super.key, this.height = kToolbarHeight, required this.title, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromHeight(height),
      painter: TrapezoidalAppBarPainter(color: color),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white,),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class TrapezoidalAppBarPainter extends CustomPainter {
  final Color color;

  TrapezoidalAppBarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color; // Use the passed color instead of hardcoded blue
    Path path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height + 80)
      ..lineTo(0, 90)
      ..lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrapezoidalAppBarPainter oldDelegate) => false;
}