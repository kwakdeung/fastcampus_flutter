import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class LabelDetectorPainter extends CustomPainter {
  LabelDetectorPainter(this.labels);

  final List<ImageLabel> labels;

  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 18,
        textDirection: TextDirection.ltr,
      ),
    );
    builder.pushStyle(ui.TextStyle(color: Colors.orange));
    for (final label in labels) {
      var text =
          'Label: ${label.label} | Confidence: ${label.confidence.toStringAsFixed(2)}\n';
      builder.addText(text);
    }
    builder.pop();
    canvas.drawParagraph(
        builder.build()
          ..layout(
            ui.ParagraphConstraints(
              width: size.width,
            ),
          ),
        Offset(16, 16));
  }

  @override
  bool shouldRepaint(LabelDetectorPainter oldDelegate) {
    return oldDelegate.labels != labels;
  }
}
