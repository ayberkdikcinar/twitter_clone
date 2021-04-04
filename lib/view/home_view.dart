import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bases/view_statefull_base.dart';
import '../core/components/custom_post_listile_widget.dart';
import '../core/components/custom_textFormField_widget.dart';
import '../core/localization/strings.dart';
import '../model/post_model.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/home_viewmodel.dart';
import 'home_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends StatefullBase<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final _homeviewmodel = Provider.of<HomeViewModel>(context);
    final _authUser = Provider.of<AuthViewModel>(context).user;
    final GlobalKey<ScaffoldState> _state = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: _state,
        appBar: AppBar(
          title: Text(
            ApplicationStrings.instance.home,
            style: textTheme.headline6,
          ),
          leading: GestureDetector(
              onTap: () => _state.currentState.openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_authUser.photo),
                  radius: 5,
                  backgroundColor: Colors.amber,
                ),
              )),
        ),
        drawer: HomeDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _floatOnPressedDialog(),
          child: Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshPage(),
          child: FutureBuilder<List<Post>>(
            future: _homeviewmodel.getLoadingPosts,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                ),
                itemCount: snapshot.data.length == 0 ? 1 : snapshot.data.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.length == 0) {
                    return Center(
                        child: Text(
                      ApplicationStrings.instance.noPostError,
                      style: textTheme.headline5,
                    ));
                  }
                  var _currentPost = snapshot.data[index];
                  return buildCustomPostListile(_currentPost);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCustomPostListile(Post _currentPost) {
    final _homeviewmodel = Provider.of<HomeViewModel>(context);
    return CustomPostListile(
      title: _currentPost.title,
      imageURL: _currentPost.photo,
      content: _currentPost.content,
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(_homeviewmodel.getUserFromList(_currentPost.owner).photo),
      ),
      userName: _homeviewmodel.getUserFromList(_currentPost.owner).username,
      postTime: '21.01.2010', ////_currentPost.time
    );
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 1));
    context.read<HomeViewModel>().setLoadingPosts();
  }

  _floatOnPressedDialog() {
    showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: new Text("Send Post"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(),
                  CustomTextFormField(maxLines: 5),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Post'),
                  onPressed: () async {
                    print('tıklandı');
                    await context.read<HomeViewModel>().addPost(Post(
                        owner: Provider.of<AuthViewModel>(context, listen: false).user.id,
                        content: 'fingvefangdostum',
                        id: '4',
                        photo: 'https://picsum.photos/200/300',
                        title: 'en son bu atıldı ama elle yazılı bunlar hep '));
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
