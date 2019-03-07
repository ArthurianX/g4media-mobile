import 'package:g4mediamobile/src/services/utils.dart';
import 'package:meta/meta.dart';

@immutable
class PostEntity{
  final int id;
  final dynamic date;
  final String modified;
  final String slug;
  final String status;
  final String type;
  final String link;
  final String title;
  final String content;
  final String excerpt;
  final int author;
  final List<dynamic> categories;
  final List<dynamic> tags;
  final String jetpack_featured_media_url;
  final String jetpack_shortlink;

  PostEntity({
    this.id,this.date,this.modified,this.slug,this.status,this.type,this.link,this.title,this.content,this.excerpt,this.author,this.categories,this.tags,this.jetpack_featured_media_url,this.jetpack_shortlink,
  });

  static PostEntity fromJson(Map<String,dynamic> json){
    var date = DateTime.parse(json['date']);
    var image = json['jetpack_featured_media_url'] != '' ? json['jetpack_featured_media_url'] : 'https://via.placeholder.com/600x400?text=G4';
    return PostEntity(
      id: json['id'],
      date: '${date.day} ${G4Utils.months[date.month - 1]} ${date.year}',
      modified: json['modified'],
      slug: json['slug'],
      status: json['status'],
      type: json['type'],
      link: json['link'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      excerpt: json['excerpt']['rendered'],
      author: json['author'],
      categories: json['categories'],
      tags: json['tags'],
      jetpack_featured_media_url: image,
      jetpack_shortlink: json['jetpack_shortlink'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'modified': modified,
    'slug': slug,
    'status': status,
    'type': type,
    'link': link,
    'title': title,
    'content': content,
    'excerpt': excerpt,
    'author': author,
    'categories': categories,
    'tags': tags,
    'jetpack_featured_media_url': jetpack_featured_media_url,
    'jetpack_shortlink': jetpack_shortlink,
  };
}
