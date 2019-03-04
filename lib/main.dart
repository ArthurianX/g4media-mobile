import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:g4mediamobile/src/services/g4media_search_api.dart';
import 'package:g4mediamobile/src/state/actions.dart';
import 'package:g4mediamobile/src/state/g4_store.dart';
import 'package:g4mediamobile/src/state/reducers.dart';
import 'package:g4mediamobile/src/state/middleware.dart';
import 'package:g4mediamobile/src/services/githup_search_api.dart';
import 'package:g4mediamobile/src/screens/home.dart';

void main() {
  final store = new Store<G4Store>(searchReducer,
      initialState: G4Store.initial(),
      middleware: [
        // SearchMiddleware(GithubApi()),
        // EpicMiddleware<G4Store>(SearchEpic(GithubApi())),
        RefreshMiddleware(G4MediaApi()),
        EpicMiddleware<G4Store>(PostsEpic(G4MediaApi())),
        MergePostsMiddleware(G4MediaApi()),
        new LoggingMiddleware.printer()
      ]);

  // Do a initial call for posts
  store.dispatch(FetchPostsAction(FetchPostsEnumType.fresh));

  runApp(new G4MediaMobile(
    store: store,
  ));
}

class G4MediaMobile extends StatelessWidget {
  final Store<G4Store> store;

  G4MediaMobile({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<G4Store>(
      store: store,
      child: new MaterialApp(
        title: 'G4 Media Mobile',
        theme: new ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.grey,
          fontFamily: 'SourceSansPro',
        ),
        home: new HomeScreen(),
      ),
    );
  }
}