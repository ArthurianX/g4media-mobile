import 'package:g4mediamobile/src/state/g4_store.dart';

class HomeScreenViewModel {
  final G4Store state;
  final void Function(String term) onTextChanged;

  HomeScreenViewModel({this.state, this.onTextChanged});
}

// TODO: Do we need a different View Model for settings ?
class GithubSearchScreenViewModel {
  final G4Store state;
  final void Function(String term) onTextChanged;

  GithubSearchScreenViewModel({this.state, this.onTextChanged});
}