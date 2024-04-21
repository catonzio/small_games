import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart' as mat;
import 'package:small_games/app/modules/eight_puzzle/models/cell.dart';

Future<List<Cell>> decodeAndCropImage(String imagePath, int imgsInRow) async {
  final List<Cell> subImages = <Cell>[];
  // Load the image using dart:ui
  ui.Image image = await decodeImage(imagePath);

  final int width = image.width;
  final int height = image.height;
  final double subWidth = width / imgsInRow;
  final double subHeight = height / imgsInRow;

  for (int i = 0; i < imgsInRow; i++) {
    for (int j = 0; j < imgsInRow; j++) {
      // Define the rectangle region to crop
      Rect cropRect =
          Rect.fromLTWH(subWidth * i, subHeight * j, subWidth, subHeight);

      // Crop the image
      ui.Image croppedImage = await cropImage(image, cropRect);

      // Convert the cropped image to bytes
      Uint8List croppedBytes = await imageToByteData(croppedImage);

      subImages.add(Cell(
          row: j,
          col: i,
          value: j * imgsInRow + i + 1,
          image: mat.Image.memory(
            croppedBytes,
            fit: BoxFit.fill,
          )));
    }
  }

  return subImages;
}

Future<ui.Image> decodeImage(String path) async {
  final File file = File(path);
  final Uint8List bytes = await file.readAsBytes();
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(bytes, (ui.Image img) {
    completer.complete(img);
  });
  return completer.future;
}

Future<ui.Image> cropImage(ui.Image image, Rect cropRect) async {
  final Completer<ui.Image> completer = Completer();
  final int width = cropRect.width.toInt();
  final int height = cropRect.height.toInt();
  final ui.Rect src = Rect.fromLTWH(
    cropRect.left,
    cropRect.top,
    width.toDouble(),
    height.toDouble(),
  );
  final ui.Rect dst = Rect.fromLTWH(
    0,
    0,
    width.toDouble(),
    height.toDouble(),
  );
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder);
  canvas.drawImageRect(image, src, dst, Paint());
  final ui.Picture picture = recorder.endRecording();
  picture.toImage(width, height).then((ui.Image img) {
    completer.complete(img);
  });
  return completer.future;
}

Future<Uint8List> imageToByteData(ui.Image image) async {
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}