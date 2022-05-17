import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class ArticleRepository {
  late final Dio dioClient;

  ArticleRepository({
    required this.dioClient,
  });

  Future<List<ArticleModel>?>? getArticles(
      {required int start, required int limit, String? contains, List? favoriteIdList}) async {
    try {
      //fetch data
      var response = await dioClient.get('/articles', queryParameters: {
        '_start': start,
        '_limit': limit,
        'title_contains': contains,
        if (favoriteIdList != null) 'id_in': favoriteIdList
      });

      List data = response.data;

      return data.map((element) => ArticleModel.fromJson(element)).toList();
    }
    //catch erros
    on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
      } else {
        print(e.message);
      }
    }
  }
}
