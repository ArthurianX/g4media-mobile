import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:g4mediamobile/src/components/posts/posts.dart';

import 'package:g4mediamobile/src/models/models.dart';
import 'package:g4mediamobile/src/services/utils.dart';
import 'package:g4mediamobile/src/state/g4_store.dart';
import 'package:g4mediamobile/src/state/actions.dart';

import 'package:g4mediamobile/src/components/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return new StoreConnector<G4Store, HomeScreenViewModel>(
      converter: (store) {
        // Get the latest posts
        return HomeScreenViewModel(
          state: store.state,
          store: store,
        );
      },
      builder: (BuildContext context, HomeScreenViewModel vm) {
        return new Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Open Drawer',
              onPressed: () {
                G4Utils.changeStatusBarLight(true);
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            elevation: 1,
            centerTitle: true,
            titleSpacing: 0.0,
            backgroundColor: Colors.white,

            title: new Image.asset('images/logo.png', height: 32/*fit: BoxFit.cover*/ ),
          ),
//          body: new Stack(
//            fit: StackFit.loose,
//            children: <Widget>[SearchGithubScreen(vm), MumuGithubScreen(vm)],
//          ),
          body: new RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () {
                /// https://github.com/flutter/flutter/blob/f408bb06f9361793ca85493c38d809ee1e2f7e30/examples/flutter_gallery/lib/demo/material/overscroll_demo.dart#L54
                /// Might consider switching to display the RefreshIndicator a different way
                final action = new RefreshCompletableAction();
                vm.store.dispatch(action);
                return action.completer.future;
              },
              child: PostsList(vm)
          ),
          drawer: MyDrawer()
        );
      },
    );
  }
}