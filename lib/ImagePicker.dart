import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:edge/convert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera,
                        size: 50,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Camera")
                ],
              ),
              onTap: () async {
                final image =
                    await _picker.getImage(source: ImageSource.camera);
                final File file = File(image!.path);
                if (file != Null) {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConvertImage(filename: file)));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Loading Please wait a moment'),
                    duration: Duration(seconds: 10),
                  ));
                }
              },
            ),
            InkWell(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.browse_gallery,
                        size: 50,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Import from Gallery')
                ],
              ),
              onTap: () async {
                PickedFile? image =
                    await _picker.getImage(source: ImageSource.gallery);
                final File file = File(image!.path);
                if (file != Null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConvertImage(filename: file)));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Loading Please wait a moment'),
                    duration: Duration(seconds: 10),
                  ));
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
