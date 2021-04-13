import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('Notifications'),
      ),
    );
  }
}
