import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endower/services/user_services.dart';

import '../model/analytics_model.dart';

class AnalyticServices {
  final _analyticCollection = FirebaseFirestore.instance.collection('analytics');
  final _userCollection = FirebaseFirestore.instance.collection('users');
  UserServices _userServices = UserServices();
  Stream<Analytics> getAnalyticsByUserId(String userId) {
    var _querysnapshots = _analyticCollection.doc(userId).snapshots();
    return _querysnapshots.map((event) => Analytics.fromJson(event.data()));
  }

  Future<void> increasePostCount(String userId) async {
    await _analyticCollection.doc(userId).update({"post_count": FieldValue.increment(1)});
  }

  Future<void> increaseFollowerCount(String userId) async {
    await _analyticCollection.doc(userId).update({"follower_count": FieldValue.increment(1)});
    var _user = await _userServices.getUserById(userId);
    await _userCollection.doc('0').collection('following').doc(userId).set(_user.toJson());
  }

  Future<void> increaseFollowingCount(String userId) async {
    await _analyticCollection.doc(userId).update({"following_count": FieldValue.increment(1)});
  }

  Future<void> decreasePostCount(String userId) async {
    await _analyticCollection.doc(userId).update({"post_count": FieldValue.increment(-1)});
  }

  Future<void> decreaseFollowerCount(String userId) async {
    await _analyticCollection.doc(userId).update({"follower_count": FieldValue.increment(-1)});
    await _userCollection.doc('0').collection('following').doc(userId).delete();
  }

  Future<void> decreaseFollowingCount(String userId) async {
    await _analyticCollection.doc(userId).update({"following_count": FieldValue.increment(-1)});
  }
}
