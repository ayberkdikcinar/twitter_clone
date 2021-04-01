import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/analytics_model.dart';
import '../model/user_model.dart';

class UserServices {
  final _fbInstance = FirebaseFirestore.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');

  Future<UserModel> getUserById(String userId) async {
    var _doc = await _userCollection.doc(userId).get();
    return UserModel.fromJson(_doc.data());
  }

  Stream<UserModel> streamGetUserById(String userId) {
    var _snapshot = _userCollection.doc(userId).snapshots();
    return _snapshot.map((event) => UserModel.fromJson(event.data()));
  }

  Future<List<String>> listFollowingUsers(userId) async {
    var _querySnapshots = await _userCollection.doc(userId).collection('following').get();
    return _querySnapshots.docs.map((e) => e.id).toList();
  }

  Future<bool> isFollowing(guestId, ownerId) async {
    var _querySnapshot = await _userCollection.doc(guestId).collection('following').doc(ownerId).get();
    if (_querySnapshot.exists) {
      return true;
    }
    return false;
  }

  Stream<Analytics> getUserProfileInformation(String userId) {
    var _querysnapshots = _fbInstance.collection('analytics').doc(userId).snapshots();
    return _querysnapshots.map((event) => Analytics.fromJson(event.data()));
  }

  Stream<List<UserModel>> searchWithUsername(String searchText) {
    var _querySnapshot = _userCollection.orderBy('username').startAt([searchText]).endAt([searchText + '\uf8ff']).limit(10).snapshots();
    var _matchedUsers = _querySnapshot.map((event) => event.docs.map((e) => UserModel.fromJson(e.data())).toList());
    return _matchedUsers;
  }
}
