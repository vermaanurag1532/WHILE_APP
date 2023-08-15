import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class ReelController with ChangeNotifier {
  final picker = ImagePicker();
  late File _selectedVideo;

  File get selectedVideo => _selectedVideo;

  Future<void> selectVideo(BuildContext context) async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Select Video Source"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickVideo(source: source);
      if (pickedFile != null) {
        _selectedVideo = File(pickedFile.path);
        Navigator.pushNamed(context, RoutesName.addReel,
            arguments: pickedFile.path);
        notifyListeners();
      }
    }
  }
}
