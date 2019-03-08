import 'dart:collection';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:g4mediamobile/src/models/post_entity.dart';

class G4Utils {
  static List<String> months = ['Ianuarie', 'Februarie', 'Martie', 'Aprilie', 'Mai',
    'Iunie', 'Iulie', 'August', 'Septembrie', 'Octombrie', 'Noiembrie', 'Decembrie'];


  static launchBrowserURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  static changeStatusBarLight(light){
    FlutterStatusbarcolor.setStatusBarWhiteForeground(light);
  }

  // Merge new posts when they arrive
  static mergePosts(List<PostEntity> existingPosts, List<PostEntity> newPosts) {
    // Merge
    var posts = [existingPosts, newPosts].expand((x) => x).toList();
    // Generate a list of ids to check for duplicates
    var ids = posts.map((item) => item.id).toList();

    // Duplicates test
    _containsId(PostEntity item) {
      var res = ids..contains(item.id)..remove(item.id);
      return res.contains(item.id);
    }

    // Remove where duplicates are found
    posts.removeWhere((item) => _containsId(item));

    return posts;
  }
}

