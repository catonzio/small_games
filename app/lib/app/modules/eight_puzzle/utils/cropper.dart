import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart' as mat;

Future<List<mat.Image>> decodeAndCropImage(
    String imagePath, int imgsInRow) async {
  final List<mat.Image> subImages = <mat.Image>[];
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
          Rect.fromLTWH(subWidth * j, subHeight * i, subWidth, subHeight);

      // Crop the image
      ui.Image croppedImage = await cropImage(image, cropRect);

      // Convert the cropped image to bytes
      Uint8List croppedBytes = await imageToByteData(croppedImage);

      subImages.add(mat.Image.memory(
        croppedBytes,
        fit: BoxFit.fill,
      ));
      // subImages.add(Cell(
      //     row: j,
      //     col: i,
      //     value: j * imgsInRow + i + 1,
      //     image: mat.Image.memory(
      //       croppedBytes,
      //       fit: BoxFit.fill,
      //     )));
    }
  }

  return subImages;
}

Future<ui.Image> decodeImage(String path) async {
  // final File file = File(path);
  // final Uint8List bytes = await file.readAsBytes();
  ByteData bytesData = await rootBundle.load(path);
  final Uint8List bytes = bytesData.buffer.asUint8List();
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
