import 'package:redux/redux.dart';
import 'package:g4mediamobile/src/state/actions.dart';
import 'package:g4mediamobile/src/state/g4_store.dart';

final searchReducer = combineReducers<G4Store>([
  TypedReducer<G4Store, SearchLoadingAction>(_onLoad),
  TypedReducer<G4Store, SearchErrorAction>(_onError),
  TypedReducer<G4Store, SearchResultAction>(_onResult),

  TypedReducer<G4Store, FetchPostsLoadingAction>(_onLoadPosts),
  TypedReducer<G4Store, FetchPostsErrorAction>(_onErrorPosts),
  TypedReducer<G4Store, FetchPostsResultAction>(_onResultPosts),
]);

G4Store _onLoad(G4Store state, SearchLoadingAction action) =>
    G4Store.loading();

G4Store _onError(G4Store state, SearchErrorAction action) =>
    G4Store.error();

G4Store _onResult(G4Store state, SearchResultAction action) =>
    G4Store(result: action.result, isLoading: false);


G4Store _onLoadPosts(G4Store state, FetchPostsLoadingAction action) =>
    G4Store.loading();

G4Store _onErrorPosts(G4Store state, FetchPostsErrorAction action) =>
    G4Store.error();

G4Store _onResultPosts(G4Store state, FetchPostsResultAction action) =>
    G4Store(posts: action.posts, isLoading: false);

