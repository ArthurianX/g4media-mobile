import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:g4mediamobile/src/screens/post.dart';
import 'package:g4mediamobile/src/services/utils.dart';
import 'package:g4mediamobile/src/models/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;

  PostCard(this.post);
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showItem(context, post),
      child: new Container(
        // alignment: FractionalOffset.center,
        margin: new EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
        child: new Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              // margin: new EdgeInsets.only(right: 16.0),
              child: new Hero(
                tag: post.slug,
                child: new Image.network(
                  post.jetpack_featured_media_url,
                  fit: BoxFit.cover,
                  height: 196.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 16.0, 0, 0),
              child: new Text(
                "${post.title}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[new Text("${post.date}")]
                ),
                new Expanded(child: new Container()),
                new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(CupertinoIcons.share),
                        tooltip: 'Share',
                        onPressed: () => {
                          Share.share('${post.link}\n${post.title}')
                        },
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.collections_solid),
                        tooltip: 'Open Original Article',
                        onPressed: () => {
                          G4Utils.launchBrowserURL(post.link)
                        },
                      )
                    ]
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


void showItem(BuildContext context, PostEntity post) {
  Navigator.push(
    context,
    new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new PostScreen(post);
      },
    ),
  );
}