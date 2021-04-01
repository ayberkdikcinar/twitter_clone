import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/custom_post_listile_widget.dart';
import 'model/analytics_model.dart';
import 'model/post_model.dart';
import 'model/user_model.dart';
import 'viewmodel/profile_viewmodel.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key, this.userId}) : super(key: key);
  final userId;
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _selectedUserId = '0';

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final _profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);

    if (widget.userId != null) {
      _selectedUserId = widget.userId;
    }
    // bool _followingOrNot = await getUserFollowing(_selectedUserId, widget.userId);
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<UserModel>(
        stream: _profileViewModel.getUser(_selectedUserId),
        builder: (context, snapshot) {
          var _user = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 150,
                color: Colors.black,
                child: profileTop(_user),
              ),
              StreamBuilder<List<Post>>(
                  stream: _profileViewModel.getPostsByUserId(_selectedUserId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var _currentPost = snapshot.data[index];
                        return postListileWithPadding(_currentPost, _profileViewModel, _user);
                      },
                    );
                  }),
            ],
          );
        },
      ),
    );
  }

  Padding postListileWithPadding(Post _currentPost, ProfileViewModel _profileViewModel, UserModel user) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: CustomPostListile(
          content: _currentPost.content,
          imageURL: _currentPost.photo,
          leading: CircleAvatar(backgroundImage: NetworkImage(user.photo)),
          title: _currentPost.title,
          userName: user.username ?? '',
        ));
  }

  Widget profileTop(UserModel user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                backgroundImage: NetworkImage(user.photo),
              ),
              Text(user.username, style: TextStyle(color: Colors.white)),
              Text('bio', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        StreamBuilder<Analytics>(
          stream: Provider.of<ProfileViewModel>(context).getProfileInformation(_selectedUserId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    profileTopcolumn(snapshot.data.postCount.toString(), 'Posts'),
                    profileTopcolumn(snapshot.data.followerCount.toString(), 'Followers'),
                    profileTopcolumn(snapshot.data.followingCount.toString(), 'Following'),
                  ],
                ),
                _selectedUserId == '0'
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ))
                    : TextButton(
                        onPressed: () {},
                        child: Text(
                          'Follow',
                          style: TextStyle(color: Colors.white),
                        )),
              ],
            );
          },
        )
      ],
    );
  }

  Widget profileTopcolumn(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text1, style: TextStyle(color: Colors.white)),
          Text(text2, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
