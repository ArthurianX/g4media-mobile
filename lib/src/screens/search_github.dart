import 'package:flutter/material.dart';
import 'package:g4mediamobile/src/components/empty_result.dart';
import 'package:g4mediamobile/src/components/search_error.dart';
import 'package:g4mediamobile/src/components/search_intro.dart';
import 'package:g4mediamobile/src/components/search_loading.dart';
import 'package:g4mediamobile/src/components/search_result.dart';
import 'package:g4mediamobile/src/models/models.dart';

class SearchGithubScreen extends StatelessWidget {
  final GithubSearchScreenViewModel vm;

  SearchGithubScreen(this.vm);

  @override
  Widget build(BuildContext context) {
    return
      new Flex(direction: Axis.vertical, children: <Widget>[
        new Container(
          padding: new EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
          child: new TextField(
            decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Github...',
            ),
            style: new TextStyle(
              fontSize: 36.0,
              fontFamily: "Hind",
              decoration: TextDecoration.none,
            ),
            onChanged: vm.onTextChanged,
          ),
        ),
        new Expanded(
          child: new Stack(
            children: <Widget>[
              // Fade in an intro screen if no term has been entered
              new SearchIntroWidget(vm.state.result?.isNoTerm ?? false),

              // Fade in an Empty Result screen if the search contained
              // no items
              new EmptyResultWidget(vm.state.result?.isEmpty ?? false),

              // Fade in a loading screen when results are being fetched
              // from Github
              new SearchLoadingWidget(vm.state.isLoading ?? false),

              // Fade in an error if something went wrong when fetching
              // the results
              new SearchErrorWidget(vm.state.hasError ?? false),

              // Fade in the Result if available
              new SearchResultWidget(vm.state.result),
            ],
          ),
        )
      ]);
  }
}
