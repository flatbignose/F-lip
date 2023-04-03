import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text(content),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context,ImageSource source) async {
  File? image;
  try {
    final pickImage =
        await ImagePicker().pickImage(source: source);
    if (pickImage != null) {

      image = File(pickImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}
