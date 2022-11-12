import 'dart:developer';
import 'dart:io' as d;

import 'dart:typed_data';

import 'package:edge/Image_editing.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ConvertImage extends StatelessWidget {
  ConvertImage({Key? key, required this.filename}) : super(key: key);
  d.File filename;

  @override
  Widget build(BuildContext context) {
    ImageProcessingclass process = ImageProcessingclass(
      filename,
    );
    log('message');
    return Scaffold(
      appBar: AppBar(title: Text('converted Image')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.file(
              filename,
              height: MediaQuery.of(context).size.height / 2,
            
            ),
           const SizedBox(
              height: 50,
            ),
            FutureBuilder(
                future: process.OpenImage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  process.apply(
                      ProcessType.kernel, [-1, -1, -1, -1, 8, -1, -1, -1, -1]);
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Image.memory(
                      process.encode() as Uint8List,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  } else {
                    return const Text('error');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
