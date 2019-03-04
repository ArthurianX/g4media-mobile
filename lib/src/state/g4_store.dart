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
    this.pageSize = 15,
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

//  factory G4Store.loading() => G4Store(isLoading: true);
//
//  factory G4Store.error() => G4Store(hasError: true);
//
//  factory G4Store.pageOffset(offset) => G4Store(pageOffset: offset + 1);
}