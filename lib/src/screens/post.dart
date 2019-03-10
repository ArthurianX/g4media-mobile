import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:g4mediamobile/flutter_html_view/flutter_html_text.dart';
import 'package:g4mediamobile/src/models/post_entity.dart';
import 'package:g4mediamobile/src/services/utils.dart';

class PostScreen extends StatelessWidget {
  final PostEntity post;
  PostScreen(this.post);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.0,
        backgroundColor: Colors.white,
        title: new Image.asset('images/logo.png', height: 32/*fit: BoxFit.cover*/ ),
        actions: <Widget>[
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
        ],

      ),
      body: new GestureDetector(
        key: new Key(post.jetpack_featured_media_url),
        onTap: () => Navigator.pop(context),
        child: new SizedBox.expand(
          child: new Container(
            child: new ListView(
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                    child: new Text(
                      "${post.title}",
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  new CachedNetworkImage(
                    imageUrl: post.jetpack_featured_media_url,
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    fit: BoxFit.cover,
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                  ),
                  new HtmlText(data: post.content),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
