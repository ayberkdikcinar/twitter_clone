import 'package:flutter/material.dart';

class CustomPostListile extends StatelessWidget {
  const CustomPostListile({
    Key key,
    this.title = '',
    this.content = '',
    this.imageURL = 'https://picsum.photos/200/300',
    this.likeOnpressed,
    this.commentOnpressed,
    this.leading,
    this.userName = '',
    this.postTime = '',
  }) : super(key: key);

  final String title;
  final String content;
  final String imageURL;
  final Function likeOnpressed;
  final Function commentOnpressed;
  final Widget leading;
  final String userName;
  final String postTime;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white24,
      leading: leading,
      title: Padding(
        padding: const EdgeInsets.only(top: 15, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(userName),
            Text(
              postTime,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Başlık',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 5),
          Text(content),
          SizedBox(height: 10),
          Image.network(
            imageURL,
            height: 200,
            width: 300,
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () => commentOnpressed,
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () => likeOnpressed,
                  ),
                  Text('like_sayisi')
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
