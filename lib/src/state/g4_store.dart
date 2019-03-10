import 'package:g4mediamobile/src/models/post_entity.dart';
import 'package:g4mediamobile/src/services/g4media_search_api.dart';
import 'package:g4mediamobile/src/services/githup_search_api.dart';
import 'dart:convert';

enum CurrentScreen { home, about_us, settings, contact, feedback }

class G4Store {
  // final SearchResult result;
  final FetchPostsResult posts;
  final SearchResult result;
  final bool hasError;
  final bool isLoading;
  final bool darkTheme;
  final int pageSize;
  final int pageOffset;
  final int currentPost;
  final CurrentScreen currentScreen;

  G4Store({
    this.posts,
    this.result,
    this.hasError = false,
    this.isLoading = false,
    this.darkTheme = false,
    this.pageSize = 10,
    this.pageOffset = 0,
    this.currentPost,
    this.currentScreen = CurrentScreen.home,
  });

  G4Store copyWith({
    FetchPostsResult posts,
    SearchResult result,
    bool hasError,
    bool isLoading,
    bool darkTheme,
    int pageSize,
    int pageOffset,
    int currentPost,
    CurrentScreen currentScreen,
  }) {
    return G4Store(
      posts: posts ?? this.posts,
      result: result ?? this.result,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
      darkTheme: darkTheme ?? this.darkTheme,
      pageSize: pageSize ?? this.pageSize,
      pageOffset: pageOffset ?? this.pageOffset,
      currentPost: currentPost ?? this.currentPost,
      currentScreen: currentScreen ?? this.currentScreen,

    );
  }

  factory G4Store.initial() =>
      new G4Store(result: SearchResult.noTerm());

  static G4Store fromJson(dynamic json) =>
      G4Store(
        posts: json != null ? new FetchPostsResult(_kindRestore(json["posts"]["kind"]), _postsRestore(json["posts"]["posts"])) : new FetchPostsResult(SearchResultKind.empty, []),
        hasError: json != null ? json["hasError"] as bool : false,
        isLoading: json != null ? json["isLoading"] as bool : false,
        darkTheme: json != null ? json["darkTheme"] as bool : false,
        pageSize: json != null ? json["pageSize"] as int : 10, // TODO: This should not be needed ?
        pageOffset: json != null ? json["pageOffset"] as int : 0, // TODO: This should not be persisted
        currentPost: json != null ? json["currentPost"] as int : 0, // TODO: This should not be persisted
        currentScreen: json != null ? _currentScreenRestore(json["currentScreen"]): CurrentScreen.home,
      );

  dynamic toJson() => {
    'posts': posts.toJson(),
//    'result': result,
    'hasError': hasError,
    'isLoading': isLoading,
    'darkTheme': darkTheme,
    'pageSize': pageSize,
    'pageOffset': pageOffset,
    'currentPost': currentPost,
    'currentScreen': currentScreen.toString(),
  };

}


_kindRestore (value) {
  if (value == 'populated') {
    return SearchResultKind.populated;
  } else {
    return SearchResultKind.empty;
  }
}

_postsRestore(posts) {
  final json = jsonDecode(posts);
  return (json as List)
      .cast<Map<String, Object>>()
      .map((Map<String, Object> item) {
    return PostEntity.fromReduxJson(item);
  }).toList();
}

_currentScreenRestore(screen) {
  switch (screen) {
    case 'home':
      return CurrentScreen.home;
    case 'about_us':
      return CurrentScreen.about_us;
    case 'settings':
      return CurrentScreen.settings;
    case 'contact':
      return CurrentScreen.contact;
    case 'feedback':
      return CurrentScreen.feedback;
  }
}