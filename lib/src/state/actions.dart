import 'package:g4mediamobile/src/services/g4media_search_api.dart';
import 'package:redux/redux.dart';
import 'package:g4mediamobile/src/services/githup_search_api.dart';

class SearchAction {
  final String term;

  SearchAction(this.term);
}

class SearchLoadingAction {}

class SearchErrorAction {}

class SearchResultAction {
  final SearchResult result;

  SearchResultAction(this.result);
}

class FetchPostsAction {
  final String queryParams;

  FetchPostsAction(this.queryParams);
}

class FetchPostsLoadingAction {}

class FetchPostsErrorAction {}

class FetchPostsResultAction {
  final FetchPostsResult posts;

  FetchPostsResultAction(this.posts);
}



