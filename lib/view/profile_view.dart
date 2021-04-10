import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bases/view_statefull_base.dart';
import '../core/components/custom_post_listile_widget.dart';
import '../core/components/custom_text_button_widget.dart';
import '../core/localization/strings.dart';
import '../model/stat_model.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'profile_settings_view.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key, this.userId}) : super(key: key);
  final userId;
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends StatefullBase<ProfileView> {
  String _selectedUserId;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final _authUser = Provider.of<AuthViewModel>(context).user;
    final _profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);

    _selectedUserId = _authUser.id;
    if (widget.userId != null) {
      _selectedUserId = widget.userId;
    }

    return MultiProvider(
      providers: [
        StreamProvider<UserModel>.value(
          value: _profileViewModel.getUser(_selectedUserId),
          initialData: _authUser,
          catchError: (context, error) => _authUser,
        ),
        StreamProvider<List<Post>>.value(
          value: _profileViewModel.getPostsByUserId(_selectedUserId),
          initialData: [],
        ),
        StreamProvider<Stat>.value(
            value: _profileViewModel.getProfileInformation(_selectedUserId),
            initialData: Stat(followerCount: 0, followingCount: 0, postCount: 0),
            catchError: (context, error) => Stat(followerCount: 0, followingCount: 0, postCount: 0)),
        StreamProvider<bool>.value(
          value: _profileViewModel.isFollowing(_authUser.id, _selectedUserId),
          initialData: false,
        ),
      ],
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(Provider.of<UserModel>(context).name),
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: dynamicHeight(0.12),
                          width: dynamicWidth(1),
                          child: Image.network(
                            'https://jssors8.azureedge.net/demos/image-slider/img/faded-monaco-scenery-evening-dark-picjumbo-com-image.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Container(
                          height: dynamicHeight(0.21),
                          color: theme.backgroundColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 10),
                      child: profileTop(Provider.of<UserModel>(context), Provider.of<Stat>(context), Provider.of<bool>(context)),
                    ),
                  ],
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: Provider.of<List<Post>>(context).length ?? 0,
                  itemBuilder: (context, index) {
                    var _currentPost = Provider.of<List<Post>>(context)[index];
                    return postListile(_currentPost, Provider.of<UserModel>(context));
                  },
                )
              ],
            ));
      },
    );
    // bool _followingOrNot = await getUserFollowing(_selectedUserId, widget.userId);
  }

  Widget profileTop(UserModel user, Stat analytics, bool following) {
    final _authUser = Provider.of<AuthViewModel>(context).user;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              backgroundImage: NetworkImage(user.photo),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: profileButton(_authUser, following),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? '',
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    '@${user.username}' ?? '',
                    style: textTheme.caption,
                  ),
                  SizedBox(height: 3),
                  Text(
                    user.bio ?? '',
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(analytics.postCount.toString(), style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.w800, fontSize: 16)),
            SizedBox(width: 2),
            Text('Posts', style: textTheme.caption),
            SizedBox(width: 10),
            Text(analytics.followingCount.toString(), style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.w800, fontSize: 16)),
            SizedBox(width: 2),
            Text(ApplicationStrings.instance.following, style: textTheme.caption),
            SizedBox(width: 10),
            Text(analytics.followerCount.toString(), style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.w800, fontSize: 16)),
            SizedBox(width: 2),
            Text(ApplicationStrings.instance.followers, style: textTheme.caption),
          ],
        )
      ],
    );
  }

  Widget profileButton(UserModel authUser, bool following) {
    if (_selectedUserId == authUser.id)
      return CustomTextButton(
        text: 'Edit Profile',
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => ProfileSettingView(),
          ));
        },
        backgroundColor: Theme.of(context).splashColor,
      );
    else if (following)
      return CustomTextButton(
        text: ApplicationStrings.instance.unfollow,
        backgroundColor: Theme.of(context).errorColor,
        onPressed: () async {
          await Provider.of<ProfileViewModel>(context, listen: false).unfollow(_selectedUserId, authUser.id);
        },
      );
    else
      return CustomTextButton(
        text: ApplicationStrings.instance.follow,
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () async {
          await Provider.of<ProfileViewModel>(context, listen: false).follow(_selectedUserId, authUser.id);
        },
      );
  }

  Widget postListile(Post _currentPost, UserModel user) {
    if (_currentPost != null) {
      return CustomPostListile(
        content: _currentPost.content,
        imageURL: _currentPost.photo,
        leading: CircleAvatar(backgroundImage: NetworkImage(user.photo)),
        title: _currentPost.title,
        userName: user.username ?? '',
      );
    } else
      return Text('There is no Post');
  }
}
