import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(String userid, File file) async {
    var _puttingfile = _firebaseStorage.ref().child(userid).child('profile_photo').putFile(file);
    var _url = await (await _puttingfile).ref.getDownloadURL();
    return _url;
  }
}
