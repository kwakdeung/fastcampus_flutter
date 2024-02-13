import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:mlkit_image_labaling_start/translate_util.dart';

class ObjectDetectorPainter extends CustomPainter {
  ObjectDetectorPainter(
    this._objects,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<DetectedObject> _objects;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = Color(0x99000000);

    for (final detectedObj in _objects) {
      final builder = ui.ParagraphBuilder(
        ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 16,
          textDirection: TextDirection.ltr,
        ),
      );
      builder.pushStyle(
        ui.TextStyle(color: Colors.white, background: background),
      );
      if (detectedObj.labels.isNotEmpty) {
        final label = detectedObj.labels.reduce((value, element) =>
            value.confidence > element.confidence ? value : element);
        builder.addText('${label.text}');
      }
      builder.pop();
      final left = translateX(detectedObj.boundingBox.left, size, imageSize,
          rotation, cameraLensDirection);
      final top = translateY(detectedObj.boundingBox.top, size, imageSize,
          rotation, cameraLensDirection);
      final right = translateX(detectedObj.boundingBox.right, size, imageSize,
          rotation, cameraLensDirection);
      final bottom = translateY(detectedObj.boundingBox.bottom, size, imageSize,
          rotation, cameraLensDirection);
      canvas.drawParagraph(
          builder.build()
            ..layout(
              ParagraphConstraints(
                width: (right - left).abs(),
              ),
            ),
          Offset(left, top));
      canvas.drawRRect(
          RRect.fromLTRBR(left, top, right, bottom, Radius.circular(8)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
