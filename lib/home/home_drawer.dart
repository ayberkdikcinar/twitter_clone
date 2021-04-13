import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/localization/strings.dart';
import '../model/stat_model.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../profile/viewmodel/profile_viewmodel.dart';
import '../profile/view/profile_view.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authUser = Provider.of<AuthViewModel>(context).user;

    return SafeArea(
      child: Drawer(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ApplicationStrings.instance.accountDetail,
                  style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w800),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(_authUser.photo),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                      iconSize: 40,
                    ),
                  ],
                ),
                Text(_authUser.name),
                Text('@${_authUser.username}', style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: StreamBuilder<Stat>(
                      stream: Provider.of<ProfileViewModel>(context).getProfileInformation(_authUser.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Row(
                          children: [
                            Text(snapshot.data.followingCount.toString()),
                            SizedBox(width: 2),
                            Text(ApplicationStrings.instance.following, style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey)),
                            SizedBox(width: 20),
                            Text(snapshot.data.followerCount.toString()),
                            SizedBox(width: 2),
                            Text(ApplicationStrings.instance.followers, style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey)),
                          ],
                        );
                      }),
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 3),
                      Text(ApplicationStrings.instance.profile)
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileView(),
                    ));
                  },
                ),
                SizedBox(height: 7),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 3),
                      Text('Logout')
                    ],
                  ),
                  onTap: () async {
                    await Provider.of<AuthViewModel>(context, listen: false).signOut();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
