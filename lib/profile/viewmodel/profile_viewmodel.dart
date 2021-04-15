import 'package:flutter/cupertino.dart';

import '../../model/post_model.dart';
import '../../model/stat_model.dart';
import '../../model/user_model.dart';
import '../../services/post_services.dart';
import '../../services/stats_services.dart';
import '../../services/user_services.dart';

class ProfileViewModel with ChangeNotifier {
  PostServices _postServices = PostServices();
  UserServices _userServices = UserServices();
  StatServices _analyticServices = StatServices();

  Stream<UserModel> getUser(String userId) {
    return _userServices.streamGetUserById(userId);
  }

  Stream<Stat> getProfileInformation(String userId) {
    return _analyticServices.getAnalyticsByUserId(userId);
  }

  Stream<List<Post>> getPostsByUserId(String userId) {
    return _postServices.getPostsByUserId(userId);
  }

  Stream<bool> isFollowing(guestId, ownerId) {
    return _userServices.isFollowing(guestId, ownerId);
  }

  Future<void> increasePostCount(String userId) {
    return _analyticServices.increasePostCount(userId);
  }

  Future<void> follow(String userId, UserModel authUser) async {
    await _analyticServices.increaseFollowerCount(userId, authUser);
  }

  Future<void> decreasePostCount(String userId) async {
    await _analyticServices.decreasePostCount(userId);
  }

  Future<void> unfollow(String userId, String guestId) async {
    await _analyticServices.decreaseFollowerCount(userId, guestId);
  }
}
