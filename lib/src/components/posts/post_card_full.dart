import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g4mediamobile/flutter_html_view/flutter_html_text.dart';
import 'package:share/share.dart';

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
            image: new NetworkImage(
              post.jetpack_featured_media_url,

            ),
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
                      children: <Widget>[new Text("${post.date.split('T')[0]}", style: new TextStyle(color: Colors.white,))]
                  ),
                  new Expanded(child: new Container()),
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(CupertinoIcons.share),
                          color: Colors.white,
                          tooltip: 'Share',
                          onPressed: () => {
                          Share.share('post.excerpt')
                          },
                        ),
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
                    new HtmlText(data: post.content),
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