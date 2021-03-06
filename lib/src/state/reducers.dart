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
  // Increase Page Offset
  TypedReducer<G4Store, FetchPostsChangeOffsetAction>(_onChangeOffset),
]);


G4Store _onLoad(G4Store state, SearchLoadingAction action) =>
    // G4Store.loading();
    state.copyWith(isLoading: true);

G4Store _onError(G4Store state, SearchErrorAction action) =>
    state.copyWith(hasError: true);

G4Store _onResult(G4Store state, SearchResultAction action) =>
    //G4Store(result: action.result, isLoading: false);
    state.copyWith(result: action.result, isLoading: false);



G4Store _onLoadPosts(G4Store state, FetchPostsLoadingAction action) =>
    state.copyWith(isLoading: true);

G4Store _onErrorPosts(G4Store state, FetchPostsErrorAction action) =>
    state.copyWith(hasError: true);

G4Store _onResultPosts(G4Store state, FetchPostsResultAction action) =>
    // G4Store(posts: action.posts, isLoading: false);
    state.copyWith(posts: action.posts, isLoading: false);

G4Store _onChangeOffset(G4Store state, FetchPostsChangeOffsetAction action) =>
    // G4Store.pageOffset(action.pageOffset);
    state.copyWith(pageOffset: action.pageOffset);

