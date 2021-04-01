import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/custom_post_listile_widget.dart';
import 'components/custom_text_button_widget.dart';
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
    return MultiProvider(
      providers: [
        StreamProvider<UserModel>.value(
          value: _profileViewModel.getUser(_selectedUserId),
          initialData: UserModel(username: '', photo: '/', email: '', id: ''),
        ),
        StreamProvider<List<Post>>.value(
          value: _profileViewModel.getPostsByUserId(_selectedUserId),
          initialData: [],
        ),
        StreamProvider<Analytics>.value(
          value: _profileViewModel.getProfileInformation(_selectedUserId),
          initialData: Analytics(),
        ),
        StreamProvider<bool>.value(
          value: _profileViewModel.isFollowing('0', _selectedUserId),
          initialData: false,
        ),
      ],
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(),
            body: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: 150,
                  color: Colors.black,
                  child: profileTop(Provider.of<UserModel>(context), Provider.of<Analytics>(context), Provider.of<bool>(context)),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: Provider.of<List<Post>>(context).length,
                  itemBuilder: (context, index) {
                    var _currentPost = Provider.of<List<Post>>(context)[index];
                    return postListileWithPadding(_currentPost, Provider.of<UserModel>(context));
                  },
                )
              ],
            ));
      },
    );
    // bool _followingOrNot = await getUserFollowing(_selectedUserId, widget.userId);
  }

  Padding postListileWithPadding(Post _currentPost, UserModel user) {
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

  Widget profileTop(UserModel user, Analytics analytics, bool following) {
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                profileTopcolumn(analytics.postCount.toString() ?? '', 'Posts'),
                profileTopcolumn(analytics.followerCount.toString() ?? '', 'Followers'),
                profileTopcolumn(analytics.followingCount.toString() ?? '', 'Following'),
              ],
            ),
            if (_selectedUserId == '0')
              CustomTextButton(
                text: 'Edit Profile',
                onPressed: () {},
                backgroundColor: Theme.of(context).splashColor,
              )
            else if (following)
              CustomTextButton(
                text: 'Unfollow',
                backgroundColor: Theme.of(context).errorColor,
                onPressed: () async {
                  await Provider.of<ProfileViewModel>(context, listen: false).decreaseFollowerCount(_selectedUserId);
                  await Provider.of<ProfileViewModel>(context, listen: false).decreaseFollowingCount('0');
                },
              )
            else
              CustomTextButton(
                text: 'Follow',
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  await Provider.of<ProfileViewModel>(context, listen: false).increaseFollowerCount(_selectedUserId);
                  await Provider.of<ProfileViewModel>(context, listen: false).increaseFollowingCount('0');
                },
              )
          ],
        )
      ],
    );
  }

  Widget profileTopcolumn(String amount, String text) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(amount, style: TextStyle(color: Colors.white)),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
