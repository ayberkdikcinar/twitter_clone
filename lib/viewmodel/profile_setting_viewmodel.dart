import 'dart:io';

import 'package:endower/services/storage_services.dart';
import 'package:endower/services/user_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsViewModel with ChangeNotifier {
  String _name;
  String _username;
  String _bio;
  String _userId;
  String _photoUrl = '';
  File _image;
  bool _loading = false;

  UserServices _userServices = UserServices();
  FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  Future<bool> saveChanges() async {
    await uploadImage();
    return await _userServices.updateUserInfo(_userId, _name, _username, _photoUrl, bio);
  }

  //Image _photo;
  //
  //
  Future<String> uploadImage() async {
    if (_image != null) {
      _photoUrl = await _firebaseStorageService.uploadImage(_userId, _image);
    }
    return _photoUrl;
  }

  Future<void> photoFrom(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setImage(File(pickedFile.path));
    }
  }

  get loading => _loading;
  get userId => _userId;
  get name => _name;
  get username => _username;
  get bio => _bio;
  get image => _image;

  void setLoading() {
    _loading = !_loading;
    notifyListeners();
  }

  void setImage(File image) {
    _image = image;
    notifyListeners();
  }

  void setUserId(String id) {
    _userId = id;
  }

  void setname(String name) {
    _name = name;
  }

  void setUsername(String username) {
    _username = username;
  }

  void setBio(String bio) {
    _bio = bio;
  }
}
