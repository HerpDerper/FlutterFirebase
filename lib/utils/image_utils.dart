import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUtils {
  static Future<XFile?> pickImage() async => await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);

  static Future<File?> cropImage(XFile file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: file.path, cropStyle: CropStyle.circle, compressQuality: 100);
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }
}
