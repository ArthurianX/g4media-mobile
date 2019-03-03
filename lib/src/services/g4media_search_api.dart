import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:g4mediamobile/src/models/post_entity.dart';

class G4MediaApi {
  final String baseUrl;
  final Map<String, FetchPostsResult> cache;
  final HttpClient client;

  G4MediaApi({
    HttpClient client,
    Map<String, FetchPostsResult> cache,
    this.baseUrl = "https://www.g4media.ro/wp-json/wp/v2/posts",
  })  : this.client = client ?? new HttpClient(),
        this.cache = cache ?? <String, FetchPostsResult>{};

  /// Search Github for repositories using the given term
//  Future<FetchPostsResult> search(String term) async {
//    if (term.isEmpty) {
//      return new FetchPostsResult.noTerm();
//    } else if (cache.containsKey(term)) {
//      return cache[term];
//    } else {
//      final result = await _fetchResults(term);
//
//      cache[term] = result;
//
//      return result;
//    }
//  }

  Future<FetchPostsResult> search(String term) async {
    final result = await _fetchResults(term);
    return result;
  }

  Future<FetchPostsResult> _fetchResults(String term) async {
    final request = await new HttpClient().getUrl(Uri.parse("$baseUrl$term"));
    final response = await request.close();
    final results = json.decode(await response.transform(utf8.decoder).join());

    return new FetchPostsResult.fromJson(results);
  }
}

enum SearchResultKind { noTerm, empty, populated }

class FetchPostsResult {
  final SearchResultKind kind;
  final List<PostEntity> items;

  FetchPostsResult(this.kind, this.items);

  factory FetchPostsResult.noTerm() =>
      new FetchPostsResult(SearchResultKind.noTerm, <PostEntity>[]);

  factory FetchPostsResult.fromJson(dynamic json) {
    final posts = (json as List)
        .cast<Map<String, Object>>()
        .map((Map<String, Object> item) {
      return PostEntity.fromJson(item);
    }).toList();

    return new FetchPostsResult(
      posts.isEmpty ? SearchResultKind.empty : SearchResultKind.populated,
      posts,
    );
  }

  bool get isPopulated => kind == SearchResultKind.populated;

  bool get isEmpty => kind == SearchResultKind.empty;

  bool get isNoTerm => kind == SearchResultKind.noTerm;
}

