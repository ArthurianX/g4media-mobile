import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:g4mediamobile/src/screens/post.dart';
import 'package:g4mediamobile/src/services/utils.dart';
import 'package:g4mediamobile/src/models/post_entity.dart';

class PostCardFull extends StatelessWidget {
  final PostEntity post;

  PostCardFull(this.post);
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showItem(context, post),
      child: new Container(
        height: MediaQuery.of(context).size.height * 0.5,
        margin: new EdgeInsets.fromLTRB(0.0, 0, 0.0, 12.0),
        decoration: new BoxDecoration(
          // color: const Color(0xff7c94b6),
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
            image: new CachedNetworkImageProvider(post.jetpack_featured_media_url),
          ),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Expanded(child: new Container()),
            new Container(
              margin: new EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: new Text(
                "${post.title}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: Colors.white,
                  fontFamily: 'SourceSansPro',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Container(
                margin: new EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[new Text("${post.date}", style: new TextStyle(color: Colors.white,))]
                  ),
                  new Expanded(child: new Container()),
                  new Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(CupertinoIcons.share),
                          tooltip: 'Share',
                          color: const Color(0xFFFFFFFF),
                          onPressed: () => {
                            Share.share('${post.link}\n${post.title}')
                          },
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.collections_solid),
                          tooltip: 'Open Original Article',
                          color: const Color(0xFFFFFFFF),
                          onPressed: () => {
                            G4Utils.launchBrowserURL(post.link)
                          },
                        )
                      ]
                  ),
                ],
              )
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