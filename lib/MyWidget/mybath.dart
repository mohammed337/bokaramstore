import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color =  Colors.blue[800]
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.quadraticBezierTo(size.width*-0.01,size.height*0.51,0,size.height*0.58);
    path_0.cubicTo(size.width*0.06,size.height*0.78,size.width*0.25,size.height*0.97,size.width*0.50,size.height*0.96);
    path_0.cubicTo(size.width*0.75,size.height*0.96,size.width*0.94,size.height*0.80,size.width,size.height*0.60);
    path_0.quadraticBezierTo(size.width*1.00,size.height*0.53,size.width,0);
    path_0.lineTo(0,0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
