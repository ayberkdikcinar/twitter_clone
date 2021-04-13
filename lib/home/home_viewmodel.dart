import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';
import '../model/user_model.dart';
import '../services/post_services.dart';
import '../services/stats_services.dart';
import '../services/user_services.dart';

class HomeViewModel with ChangeNotifier {
  List<UserModel> _userList;

  ///for comment window
  Future<List<Post>> _loadingPosts;
  PostServices _postServices = PostServices();
  UserServices _userServices = UserServices();
  StatServices _analyticServices = StatServices();
  String _postTitle;
  String _postContent;
  UserModel _user;
  HomeViewModel() {
    _userList = [];
    _loadingPosts = getAllPosts();
  }

  List<UserModel> get getUserList => _userList;
  Future<List<Post>> get getLoadingPosts => _loadingPosts;

  void setLoadingPosts() {
    _userList = [];
    _loadingPosts = getAllPosts();
    notifyListeners();
  }

  Future<void> addPost(Post post) async {
    await _postServices.addPost(post);
    _analyticServices.increasePostCount(post.owner);
  }

  UserModel getUserFromList(String id) {
    for (var item in _userList) {
      if (id == item.id) {
        return item;
      }
    }
    return null;
  }

  Future<List<Post>> getAllPosts() async {
    var _posts = await _postServices.getFollowingPosts();

    for (var post in _posts) {
      bool flag = false;
      var _user1 = await getUserById(post.owner);
      if (_userList.isEmpty) {
        _userList.add(_user1);
      }
      for (var user in _userList) {
        if (_user1.id == user.id) {
          flag = true;
          break;
        }
      }
      if (flag != true) {
        _userList.add(_user1);
      }
    }
    print('çalıştı');
    return _posts;
  }

  String get postTitle => _postTitle;
  void setPostTitle(String value) {
    _postTitle = value;
  }

  String get postContent => _postContent;
  void setPostContent(String value) {
    _postContent = value;
  }

  Future<UserModel> getUserById(String userId) async {
    print('çalıştı get user');
    return await _userServices.getUserById(userId);
  }

  UserModel get currentUser => _user;
}
