import 'package:endower/services/notification_services.dart';
import 'package:endower/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatefulWidget {
  NotificationView({Key key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/200/300'),
        ),
        title: Text('Notifications'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: FutureBuilder<List<String>>(
            future: NotificationService().getNotification(Provider.of<AuthViewModel>(context).user.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text('There is no notification yet'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(child: Text(snapshot.data[index])),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
