import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_services.dart';

import '../model/stat_model.dart';
import 'auth_services.dart';
import 'user_services.dart';

class StatServices {
  final _analyticCollection = FirebaseFirestore.instance.collection('analytics');
  final _userCollection = FirebaseFirestore.instance.collection('users');
  UserServices _userServices = UserServices();
  final NotificationService _notificationService = NotificationService();

  Future<void> createAnalytic(String userId) async {
    var _user = await FirebaseAuthServices().currentUser();
    var _initAnalytics = Stat(followerCount: 0, followingCount: 0, postCount: 0, owner: userId);
    await _userCollection.doc(userId).collection('following').doc(userId).set(_user.toJson());
    await _analyticCollection.doc(userId).set(_initAnalytics.toJson());
  }

  Stream<Stat> getAnalyticsByUserId(String userId) {
    var _querysnapshots = _analyticCollection.doc(userId).snapshots();
    return _querysnapshots.map((event) => Stat.fromJson(event.data()));
  }

  Future<Stat> futGetAnalyticsByUserId(String userId) async {
    var _docsnapshots = await _analyticCollection.doc(userId).get();
    return Stat.fromJson(_docsnapshots.data());
  }

  Future<void> increasePostCount(String userId) async {
    await _analyticCollection.doc(userId).update({"post_count": FieldValue.increment(1)});
  }

  Future<void> decreasePostCount(String userId) async {
    await _analyticCollection.doc(userId).update({"post_count": FieldValue.increment(-1)});
  }

  Future<void> increaseFollowerCount(String userId, String guestId) async {
    await _analyticCollection.doc(userId).update({"follower_count": FieldValue.increment(1)});
    var _user = await _userServices.getUserById(userId);
    var _guestUser = await _userServices.getUserById(guestId);
    await _notificationService.sendNotification(_guestUser, userId);
    await _analyticCollection.doc(guestId).update({"following_count": FieldValue.increment(1)});
    await _userCollection.doc(guestId).collection('following').doc(userId).set(_user.toJson());
  }

  Future<void> decreaseFollowerCount(String userId, String guestId) async {
    await _analyticCollection.doc(userId).update({"follower_count": FieldValue.increment(-1)});
    await _analyticCollection.doc(guestId).update({"following_count": FieldValue.increment(-1)});
    await _userCollection.doc(guestId).collection('following').doc(userId).delete();
  }
}
