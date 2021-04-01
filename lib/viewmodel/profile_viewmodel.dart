import 'package:flutter/cupertino.dart';
import '../model/analytics_model.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../services/analytics_services.dart';
import '../services/post_services.dart';
import '../services/user_services.dart';

class ProfileViewModel with ChangeNotifier {
  PostServices _postServices = PostServices();
  UserServices _userServices = UserServices();
  AnalyticServices _analyticServices = AnalyticServices();

  Stream<UserModel> getUser(String userId) {
    return _userServices.streamGetUserById(userId);
  }

  Stream<Analytics> getProfileInformation(String userId) {
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

  Future<void> increaseFollowerCount(String userId) {
    return _analyticServices.increaseFollowerCount(userId);
  }

  Future<void> increaseFollowingCount(String userId) {
    return _analyticServices.increaseFollowingCount(userId);
  }

  Future<void> decreasePostCount(String userId) {
    return _analyticServices.decreasePostCount(userId);
  }

  Future<void> decreaseFollowerCount(String userId) {
    return _analyticServices.decreaseFollowerCount(userId);
  }

  Future<void> decreaseFollowingCount(String userId) {
    return _analyticServices.decreaseFollowingCount(userId);
  }
}
