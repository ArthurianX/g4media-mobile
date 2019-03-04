import 'package:flutter/material.dart';
import 'package:g4mediamobile/src/components/posts/post_card.dart';
import 'package:g4mediamobile/src/components/posts/post_card_full.dart';
import 'package:g4mediamobile/src/models/models.dart';
import 'package:g4mediamobile/src/state/actions.dart';

class PostsList extends StatelessWidget {
  final HomeScreenViewModel vm;

  PostsList(this.vm);

  @override
  Widget build(BuildContext context) {
    return new NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification && scrollNotification.metrics.pixels > 100.0 && scrollNotification.metrics.atEdge) {
          vm.store.dispatch(FetchPostsAction(FetchPostsEnumType.paged));
        }
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
          color: Colors.black26,
        ),
        itemCount: vm.state.posts !=null && vm.state.posts.items.length > 0 ? vm.state.posts.items.length + 1 : 0,

        itemBuilder: (_, index) {
          if (vm.state.posts == null) {
            return new Container();
          } else if (vm.state.posts.items.length == index) {
            // vm.store.dispatch(FetchPostsAction(FetchPostsEnumType.paged));
            return const Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Center(
                child: const CircularProgressIndicator(),
              ),
            );
          } else if (index == 0) {
            return PostCardFull(vm.state.posts.items[index]);
          } else {
            return PostCard(vm.state.posts.items[index]);
          }
        },
      ),
    );
  }
}
