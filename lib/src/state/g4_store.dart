import 'package:g4mediamobile/src/models/post_entity.dart';
import 'package:g4mediamobile/src/services/g4media_search_api.dart';
import 'package:redux/redux.dart';
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
    // this.result,
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

  factory G4Store.initial() =>
      new G4Store(result: SearchResult.noTerm());

  factory G4Store.loading() => G4Store(isLoading: true);

  factory G4Store.error() => G4Store(hasError: true);
}