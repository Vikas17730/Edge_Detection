import 'dart:io';

import 'package:edge/ImagePicker.dart';
import 'package:edge/convert.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  File? _categoryImageFile;
  // This widget is the root of your application.
  void _pickedImage(File image) {
    _categoryImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Image Processing app"),
        ),
        body: Center(child: PickImage()),
      ),
    );
  }
}
