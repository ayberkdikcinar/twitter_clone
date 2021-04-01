class Analytics {
  int followerCount;
  int followingCount;
  String owner;
  int postCount;

  Analytics({this.followerCount, this.followingCount, this.owner, this.postCount});

  Analytics.fromJson(Map<String, dynamic> json) {
    followerCount = json['follower_count'];
    followingCount = json['following_count'];
    owner = json['owner'];
    postCount = json['post_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['follower_count'] = this.followerCount;
    data['following_count'] = this.followingCount;
    data['owner'] = this.owner;
    data['post_count'] = this.postCount;
    return data;
  }
}
