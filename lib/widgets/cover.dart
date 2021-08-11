import 'package:app_prueba/const/gradient.dart';
import 'package:flutter/material.dart';

Widget buildCoverImage(Size screenSize) {
  return new ClipPath(
    clipper: MyClipper(),
    child: Container(
      height: screenSize.height / 1.8,
      decoration: BoxDecoration(
        gradient: farletzaGradient,
      ),
    ),
  );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.3);
    p.arcToPoint(
      Offset(0.0, size.height * 0.50),
      radius: const Radius.elliptical(60.0, 20.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
