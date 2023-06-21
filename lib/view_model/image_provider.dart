import 'dart:io';
import 'package:flutter/material.dart';

class Imageprovider extends ChangeNotifier{

  File? _profileImage;
  File? _bgImage;

  File? get profileImage=> _profileImage;
  File? get bgImage=> _bgImage;

  void setProfile(File image){
    _profileImage=image;
    notifyListeners();
  }

  void setBg(File image){
    _bgImage=image;
    notifyListeners();
  }
  
}