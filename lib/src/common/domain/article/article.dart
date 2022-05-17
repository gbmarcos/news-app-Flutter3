
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';


List<Article> articlesFromJson(List<dynamic> str) =>
    List<Article>.from(str.map<Article>((dynamic x) => Article.fromJson(x as Map<String, dynamic>)));

@freezed
class Article with _$Article{

  factory Article({
    int? id,
    bool? featured,
    String? title,
    String? url,
    String? imageUrl,
    String? newsSite,
    String? summary,
    DateTime? publishedAt,
  }) = _Article;


  const Article._();

  factory Article.fromJson(Map<String, dynamic> map) => _$ArticleFromJson(map);
}
