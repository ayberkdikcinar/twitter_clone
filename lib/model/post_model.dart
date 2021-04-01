import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String title;
  String content;
  String photo;
  String owner;
  String id;
  String commentId;
  int like;
  Timestamp time;
  Post({this.title, this.content, this.photo, this.owner, this.id, this.commentId, this.like, this.time});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    photo = json['photo'];
    owner = json['owner'];
    id = json['id'];
    commentId = json['commentId'];
    like = json['like'];
    time = json['time'] ?? Timestamp.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['photo'] = this.photo;
    data['owner'] = this.owner;
    data['id'] = this.id;
    data['commentId'] = this.commentId;
    data['like'] = this.like;
    data['time'] = this.time ?? Timestamp.now();
    return data;
  }
}
