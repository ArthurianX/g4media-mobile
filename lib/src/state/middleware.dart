import 'dart:async';
import 'package:async/async.dart';
import 'package:g4mediamobile/src/services/g4media_search_api.dart';
import 'package:g4mediamobile/src/state/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'package:g4mediamobile/src/services/githup_search_api.dart';
import 'package:g4mediamobile/src/state/g4_store.dart';

/// The Search Middleware will listen for Search Actions and perform the search
/// after the user stop typing for 250ms.
///
/// If a previous search was still loading, we will cancel the operation and
/// fetch a new set of results. This ensures only results for the latest search
/// term are shown.
class SearchMiddleware implements MiddlewareClass<G4Store> {
  final GithubApi api;

  Timer _timer;
  CancelableOperation<Store<G4Store>> _operation;

  SearchMiddleware(this.api);

  @override
  void call(Store<G4Store> store, dynamic action, NextDispatcher next) {
    if (action is SearchAction) {
      // Stop our previous debounce timer and search.
      _timer?.cancel();
      _operation?.cancel();

      // Don't start searching until the user pauses for 250ms. This will stop
      // us from over-fetching from our backend.
      _timer = new Timer(new Duration(milliseconds: 250), () {
        store.dispatch(SearchLoadingAction());

        // Instead of a simple Future, we'll use a CancellableOperation from the
        // `async` package. This will allow us to cancel the previous operation
        // if a new Search term comes in. This will prevent us from
        // accidentally showing stale results.
        _operation = CancelableOperation.fromFuture(
            api
            .search(action.term)
            .then((result) => store..dispatch(SearchResultAction(result)))
            .catchError((e, s) => store..dispatch(SearchErrorAction()))
        );
      });
    }

    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }
}

/// The Search Epic provides the same functionality as the Search Middleware,
/// but uses redux_epics and the RxDart package to perform the work. It will
/// listen for Search Actions and perform the search after the user stop typing
/// for 250ms.
///
/// If a previous search was still loading, we will cancel the operation and
/// fetch a new set of results. This ensures only results for the latest search
/// term are shown.
class SearchEpic implements EpicClass<G4Store> {
  final GithubApi api;

  SearchEpic(this.api);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<G4Store> store) {
    return Observable(actions)
    // Narrow down to SearchAction actions
        .ofType(TypeToken<SearchAction>())
    // Don't start searching until the user pauses for 250ms
        .debounce(new Duration(milliseconds: 250))
    // Cancel the previous search and start a new one with switchMap
        .switchMap((action) => _search(action.term));
  }

  // Use the async* function to make our lives easier
  Stream<dynamic> _search(String term) async* {
    // Dispatch a SearchLoadingAction to show a loading spinner
    yield SearchLoadingAction();

    try {
      // If the api call is successful, dispatch the results for display
      yield SearchResultAction(await api.search(term));
    } catch (e) {
      // If the search call fails, dispatch an error so we can show it
      yield SearchErrorAction();
    }
  }
}


/// Posts Epic - Get Posts from G4Media
class PostsEpic implements EpicClass<G4Store> {
  final G4MediaApi api;

  PostsEpic(this.api);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<G4Store> store) {
    return Observable(actions)
    // Narrow down to FetchPostsAction actions
        .ofType(TypeToken<FetchPostsAction>())
    // Don't start searching until the user pauses for 250ms
        .debounce(new Duration(milliseconds: 250))
    // Cancel the previous search and start a new one with switchMap
        .switchMap((action) => _search(action.queryParams));
  }

  // Use the async* function to make our lives easier
  Stream<dynamic> _search(String queryParams) async* {
    // Dispatch a SearchLoadingAction to show a loading spinner
    yield FetchPostsLoadingAction();

    try {
      // If the api call is successful, dispatch the results for display
      yield FetchPostsResultAction(await api.search(queryParams));
    } catch (e) {
      // If the search call fails, dispatch an error so we can show it
      yield FetchPostsErrorAction();
    }
  }
}
