import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';

Future<Size> getImageSize(String path) async {
  final bytes = await File(path).readAsBytes();
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(bytes, (ui.Image img) => completer.complete(img));
  final img = await completer.future;
  return Size(img.width.toDouble(), img.height.toDouble());
}
