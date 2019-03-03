import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:g4mediamobile/src/models/models.dart';
import 'package:g4mediamobile/src/state/g4_store.dart';
import 'package:g4mediamobile/src/state/actions.dart';

import 'package:g4mediamobile/src/components/drawer_menu.dart';
import 'package:g4mediamobile/src/screens/search_github.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<G4Store, GithubSearchScreenViewModel>(
      converter: (store) {
        return GithubSearchScreenViewModel(
          state: store.state,
          onTextChanged: (term) => store.dispatch(SearchAction(term)),
        );
      },
      builder: (BuildContext context, GithubSearchScreenViewModel vm) {
        return new Scaffold(
          appBar: AppBar(
            // Here we take the value from the HomeScreen object that was created by
            // the App.build method, and use it to set our appbar title.
            // title: Text(widget.title),
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
          body: SearchGithubScreen(vm),
          drawer: MyDrawer()
        );
      },
    );
  }
}
