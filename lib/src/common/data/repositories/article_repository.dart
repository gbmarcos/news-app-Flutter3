import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:news_app/src/common/data/network_services.dart';
import 'package:news_app/src/common/exceptions.dart';

import '../../domain/article/article.dart';

typedef ArticleListMonad = Either<NetworkException, List<Article>>;

class ArticleRepository {


  Future<ArticleListMonad> getArticles(
      {required int start, required int limit, String? contains, List? favoriteIdList}) async {

      //fetch data
      var response = await dioGet('/articles', query: {
        '_start': start,
        '_limit': limit,
        'title_contains': contains,
        if (favoriteIdList != null) 'id_in': favoriteIdList
      });

      return response.map<List<Article>>((dynamic a) => articlesFromJson(a as List<dynamic>));

    }


}
