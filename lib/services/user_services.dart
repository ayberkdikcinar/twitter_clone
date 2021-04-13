import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/stat_model.dart';
import '../model/user_model.dart';

class UserServices {
  final _fbInstance = FirebaseFirestore.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> saveUser(UserModel user) async {
    await _userCollection.doc(user.id).set(user.toJson());
  }

  Future<UserModel> getUserById(String userId) async {
    var _doc = await _userCollection.doc(userId).get();
    if (_doc.exists) {
      return UserModel.fromJson(_doc.data());
    }
    return null;
  }

  Stream<UserModel> streamGetUserById(String userId) {
    var _snapshot = _userCollection.doc(userId).snapshots();
    return _snapshot.map((event) => UserModel.fromJson(event.data()));
  }

  Future<List<String>> listFollowingUsers(userId) async {
    var _querySnapshots = await _userCollection.doc(userId).collection('following').get();
    return _querySnapshots.docs.map((e) => e.id).toList();
  }

  Stream<bool> isFollowing(guestId, ownerId) {
    var _querySnapshot = _userCollection.doc(guestId).collection('following').doc(ownerId).snapshots();
    return _querySnapshot.map((event) => event.exists);
  }

  Stream<Stat> getUserProfileInformation(String userId) {
    var _querysnapshots = _fbInstance.collection('analytics').doc(userId).snapshots();
    return _querysnapshots.map((event) => Stat.fromJson(event.data()));
  }

  Stream<List<UserModel>> searchWithUsername(String searchText) {
    var _querySnapshot = _userCollection.orderBy('username').startAt([searchText]).endAt([searchText + '\uf8ff']).limit(10).snapshots();
    var _matchedUsers = _querySnapshot.map((event) => event.docs.map((e) => UserModel.fromJson(e.data())).toList());
    return _matchedUsers;
  }

  Future<bool> updateUserInfo(String userId, String name, String username, String photoUrl, String bio) async {
    var query = await _userCollection.where('username', isEqualTo: username.toString()).get();
    if (query.docs.isNotEmpty && query.docs.first.id != userId) {
      return false;
    }
    if (photoUrl != '') {
      await _userCollection.doc(userId).update({'name': name, 'username': username, 'photo': photoUrl, 'bio': bio});
    } else {
      await _userCollection.doc(userId).update({'name': name, 'username': username, 'bio': bio});
    }
    return true;
  }
}
