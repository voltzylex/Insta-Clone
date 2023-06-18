import 'dart:developer';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource image) async {
  final imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return await file.readAsBytes();
  }
  log("NO image selected");
}
