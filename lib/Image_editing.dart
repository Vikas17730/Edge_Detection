import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as m;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ImageProcessingclass {
  final File name;
  ImageProcessingclass(this.name);
  img.Image? _image;
  img.Image? get image => _image;
  set setImage(img.Image? image) {
    _image = image;
  }

  OpenImage() async {
    Uint8List bytes = name.readAsBytesSync();
    ByteData rawdata = ByteData.view(bytes.buffer);

    setImage = img.decodeImage(rawdata.buffer.asUint8List());
  }

  List _constructRGBAList() {
    Uint8List pixels = image!.getBytes(format: img.Format.rgba);
    List newPixelList = [];
    for (int y = 0; y < image!.height; y++) {
      newPixelList.add([]);
      for (int x = 0; x < image!.width; x++) {
        var pixelLocation = (y * image!.width + x) * 4;
        int r = pixels[pixelLocation];
        int g = pixels[pixelLocation + 1];
        int b = pixels[pixelLocation + 2];
        int a = pixels[pixelLocation + 3];
        newPixelList[y].add([r, g, b, a]);
      }
    }
    return newPixelList;
  }

  apply(ProcessType type, List kernel) {
    List pixelList = _constructRGBAList();

    if (type == ProcessType.kernel) {
      var height = image!.height;
      var width = image!.width;
      for (int y = 0; y < height-2; y++) {
        for (int x = 0; x < width-2; x++) {
          int r = 0, g = 0,b=0, a = 255;
          for (int ky = 0; ky < m.sqrt(kernel.length).floor(); ky++) {
            for (int kx = 0; kx < m.sqrt(kernel.length).floor(); kx++) {
              List<int> px = pixelList[y + ky][x + kx];
              var kernelpos = (ky * 3 + kx);
              r += (px[0]* kernel[kernelpos]).round();
              g += (px[1] * kernel[kernelpos]).round();
              b += (px[2] * kernel[kernelpos]).round();
              a += (px[3] *  kernel[kernelpos]).round();
            } 
          }
          image!.setPixelRgba(x, y, r, g, b);
        }
      }
    }
  }

  encode() {
    return img.encodeJpg(image!);
  }
}

enum ProcessType { kernel, filter }
