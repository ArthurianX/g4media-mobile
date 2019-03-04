import 'dart:async';

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

// Types of calls we're making, getting the first page, or paged calls
enum FetchPostsEnumType { paged, fresh }

// Initial Action, start getting posts
class FetchPostsAction {
  final FetchPostsEnumType fetchType;

  FetchPostsAction(this.fetchType);
}

// Loading Action
class FetchPostsLoadingAction {}

// Error Action
class FetchPostsErrorAction {}

// Success Action
class FetchPostsResultAction {
  final FetchPostsResult posts;

  FetchPostsResultAction(this.posts);
}

// Intermediary action, get existing posts and merge with new ones.
class FetchPostsProcessAction {
  final FetchPostsResult posts;

  FetchPostsProcessAction(this.posts);
}

class FetchPostsChangeOffsetAction {
  final int pageOffset;

  FetchPostsChangeOffsetAction(this.pageOffset);
}


class RefreshCompletableAction {
  final Completer completer;

  RefreshCompletableAction({Completer completer})
      : this.completer = completer ?? new Completer();
}

