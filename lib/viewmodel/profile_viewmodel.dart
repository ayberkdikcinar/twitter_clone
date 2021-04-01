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
    return _userServices.getUserProfileInformation(userId);
  }

  Stream<List<Post>> getPostsByUserId(String userId) {
    return _postServices.getPostsByUserId(userId);
  }

  /*Future<bool> getUserFollowing1(String userId, String otherId) async {
    return _userServices.getUserFollowing1(userId, otherId);
  }*/
}
