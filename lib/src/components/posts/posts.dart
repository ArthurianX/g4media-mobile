import 'package:flutter/material.dart';
import 'package:g4mediamobile/src/components/posts/post_card.dart';
import 'package:g4mediamobile/src/models/models.dart';

class PostsList extends StatelessWidget {
  final HomeScreenViewModel vm;

  PostsList(this.vm);

  // initial item count, in your case `_itemCount = _friendList.length` initially
  int _itemCount = 10;

  // TODO: This is crap / stackoverflow, do it right.
  void _refreshFriendList() {
    debugPrint("List Reached End - Refreshing");

    // Make api call to fetch new data
    new Future<dynamic>.delayed(new Duration(seconds: 5)).then((_){
      // after new data received
      // add the new data to the existing list

      _itemCount = _itemCount + 10; // update the item count to notify newly added friend list
        // in your case `_itemCount = _friendList.length` or `_itemCount = _itemCount + newData.length`
    });
  }

  // Function that initiates a refresh and returns a CircularProgressIndicator - Call when list reaches its end
  Widget _reachedEnd(){
    _refreshFriendList();
    return const Padding(
      padding: const EdgeInsets.all(20.0),
      child: const Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: vm.state.posts !=null && vm.state.posts.items.length > 0 ? vm.state.posts.items.length : 0,
      // itemCount: vm.state.posts.items.isNotEmpty ? vm.state.posts.items.length : 1,
      itemBuilder: (_, index) {
        if (vm.state.posts == null) {
          return new Container();
        } else {
          final Widget listTile = index == vm.state.posts.items.length // check if the list has reached its end, if reached end initiate refresh and return refresh indicator
              ? _reachedEnd() // Initiate refresh and get Refresh Widget
              : PostCard(vm.state.posts.items[index]);
          return listTile;
        }
      },
    );
  }
}
