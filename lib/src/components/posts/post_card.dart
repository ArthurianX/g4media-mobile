import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:share/share.dart';

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
        margin: new EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
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
                  height: 168.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            new Text(
              "${post.title}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
        return new Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            // Here we take the value from the HomeScreen object that was created by
            // the App.build method, and use it to set our appbar title.
            // title: Text(widget.title),
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
                  Share.share('post.excerpt')
                },
              ),
            ],

          ),
          body: new GestureDetector(
            key: new Key(post.jetpack_featured_media_url),
            onTap: () => Navigator.pop(context),
            child: new SizedBox.expand(
//              child: new Hero(
//                tag: post.slug,
// TODO: Hero looks weird here? maybe find a way to make it better, e.g. load photo the opacity text
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

                    new Image.network(
                      post.jetpack_featured_media_url,
                      fit: BoxFit.contain,
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                    new HtmlTextView(data: post.content),
                  ]
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

_onShareTap(context, post) {
  final RenderBox box = context.findRenderObject();
  Share.share('post.excerpt',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}