import 'package:g4mediamobile/src/services/g4media_search_api.dart';
import 'package:g4mediamobile/src/services/githup_search_api.dart';

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
    this.pageSize = 30,
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
        posts: new FetchPostsResult(SearchResultKind.empty, []) ?? json["posts"] as FetchPostsResult,
//        result: new SearchResult(SearchResultGithubKind.empty, []) ?? json["result"] as SearchResult,
        hasError: false ?? json["hasError"] as bool,
        isLoading: false ?? json["isLoading"] as bool,
        darkTheme: false ?? json["darkTheme"] as bool,
        pageSize: 15 ?? json["pageSize"] as int,
        pageOffset: 0 ?? json["pageOffset"] as int,
        currentPost: 0 ?? json["currentPost"] as int,
        currentScreen: CurrentScreen.home ?? json["currentScreen"] as CurrentScreen,
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