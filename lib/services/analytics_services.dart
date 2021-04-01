import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/analytics_model.dart';

class AnalyticServices {
  final _analyticCollection = FirebaseFirestore.instance.collection('analytics');

  Stream<Analytics> getAnalyticsByUserId(String userId) {
    var _querysnapshots = _analyticCollection.doc(userId).snapshots();
    return _querysnapshots.map((event) => Analytics.fromJson(event.data()));
  }

  void increasePostCount(String userId) {
    _analyticCollection.doc(userId).update({"post_count": FieldValue.increment(1)});
  }

  void increaseFollowerCount(String userId) {
    _analyticCollection.doc(userId).update({"follower_count": FieldValue.increment(1)});
  }

  void increaseFollowingCount(String userId) {
    _analyticCollection.doc(userId).update({"following_count": FieldValue.increment(1)});
  }
}
