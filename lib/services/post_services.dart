import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/post_model.dart';
import 'user_services.dart';

class PostServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addPost(Post post) async {
    try {
      await _firestore.collection('posts').doc().set(post.toJson());
      return true;
    } catch (e) {
      print('an error while adding user to firestore' + e.toString());
      return false;
    }
  }

  Stream<List<Post>> getPostsByUserId(String userId) {
    try {
      var _snapshot = _firestore.collection('posts').where('owner', isEqualTo: userId).snapshots();

      return _snapshot.map((event) => event.docs.map((e) => Post.fromJson(e.data())).toList());
    } catch (e) {
      print('an error while getting user posts by id ' + e.toString());
      return null;
    }
  }

  Future<List<Post>> getAllPosts() async {
    try {
      var _doc = await _firestore.collection('posts').get();
      return _doc.docs.map((e) => Post.fromJson(e.data())).toList();
    } catch (e) {
      print('an error while getting all posts in the system ' + e.toString());
      return [];
    }
  }

  Future<List<Post>> getFollowingPosts() async {
    try {
      List<String> _usersFollowing = await UserServices().listFollowingUsers('0');
      var _querysnapshot = await _firestore.collection('posts').where('owner', whereIn: _usersFollowing).get();
      return _querysnapshot.docs.map((e) => Post.fromJson(e.data())).toList();
    } catch (e) {
      print('an error while getting all posts in the system ' + e.toString());
      return [];
    }
  }
}
