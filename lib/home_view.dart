import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/custom_post_listile_widget.dart';
import 'components/custom_textFormField_widget.dart';
import 'model/post_model.dart';
import 'viewmodel/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final _homeviewmodel = Provider.of<HomeViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _floatOnPressedDialog(),
          child: Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshPage(),
          child: FutureBuilder<List<Post>>(
            future: _homeviewmodel.getLoadingPosts,
            builder: (context, snapshot) {
              if (!snapshot.hasData || _homeviewmodel.getUserList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var _currentPost = snapshot.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: buildCustomPostListile(_currentPost),
                  );
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
      leading: Container(
        height: 100,
        width: 50,
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(_homeviewmodel.getUserFromList(_currentPost.owner).photo),
        ),
      ),
      userName: _homeviewmodel.getUserFromList(_currentPost.owner).username,
      postTime: '21.01.2010',
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
                    await context
                        .read<HomeViewModel>()
                        .addPost(Post(owner: '1', content: 'fingvefangdostum', id: '4', photo: 'https://picsum.photos/200/300', title: 'en son bu atıldı'));
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
