import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/components/custom_textField_widget.dart';
import '../model/user_model.dart';
import '../viewmodel/search_viewmodel.dart';
import 'profile_view.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          hintText: 'search',
          onChanged: (value) => Provider.of<SearchViewModel>(context, listen: false).setSearchText(value),
        ),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: Provider.of<SearchViewModel>(context).searchWithUsername(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileView(
                            userId: snapshot.data[index].id,
                          )));

                  print(snapshot.data[index].id);
                },
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].photo)),
                  title: Text(snapshot.data[index].username),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
