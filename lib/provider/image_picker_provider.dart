import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  List<File?> _selectedImages = [null, null, null, null, null, null];

  File? get selectedImage => _selectedImage;
  List<File?> get selectedImages => _selectedImages;

  void updateSelectedImage(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final imgXFile = await _picker.pickImage(source: ImageSource.camera);
    if (imgXFile != null) {
      _selectedImage = File(imgXFile.path);
    }

    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    final imgXFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imgXFile != null) {
      _selectedImage = File(imgXFile.path);
    }

    notifyListeners();
  }

  Future<void> pickImageFromCameraForProduct(int index) async {
    List<XFile>? imgXFiles = await _picker.pickMultiImage();

    for (int i = 0; i < imgXFiles.length && i < 6; i++) {
      _selectedImages[i] = File(imgXFiles[i].path);
    }

    notifyListeners();
  }

  Future<void> pickImageFromGalleryForProduct(int index) async {
    List<XFile>? imgXFiles = await _picker.pickMultiImage();

    for (int i = 0; i < imgXFiles.length && i < 6; i++) {
      _selectedImages[i] = File(imgXFiles[i].path);
    }

    notifyListeners();
  }

  void reset() {
    _selectedImage = null;
    _selectedImages = [null, null, null, null, null, null];
    notifyListeners();
  }
}
