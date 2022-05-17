import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api_service/client.dart';
import 'package:news_app/api_service/repositories/article_repository.dart';
import 'package:news_app/models/article_model.dart';


class ArticleCubit extends Cubit<List<ArticleModel>?> {

  //to perform lazy loading
  final int limit = 10;

  ArticleCubit() : super(null);

  Future<void> loadArticles({String? contains, List? favoriteIdList}) async {
    //if favoriteIdList is a not null empty list, ArticleCubit emits a empty ArticleModel list
    if (favoriteIdList != null && favoriteIdList.isEmpty) {
      emit(<ArticleModel>[]);
      return;
    }

    List<ArticleModel>? response = await ArticleRepository(dioClient: dioClient).getArticles(
      start: 0,
      limit: limit,
      contains: contains,
      favoriteIdList: favoriteIdList,
    );

    if (response != null) {
      emit(response);
    }
  }

  Future<void> loadMoreArticles({String? contains, List? favoriteIdList}) async {

    //if favoriteIdList is a not null empty list, ArticleCubit emits a empty ArticleModel list
    if (favoriteIdList != null && favoriteIdList.isEmpty) {
      emit(<ArticleModel>[]);
      return;
    }

    int start = state?.length ?? 0;
    print("loading more");
    List<ArticleModel>? response = await ArticleRepository(dioClient: dioClient).getArticles(
      start: start,
      limit: limit,
      contains: contains,
      favoriteIdList: favoriteIdList,
    );
    if (response != null) {
      if (state != null) {
        List<ArticleModel> newState = state! + response;
        emit(newState);
      } else {
        emit(response);
      }
    }
  }

  void removeArticle(int id){
    var newState = state?.where((article) => article.id!=id).toList();
    emit(newState);
  }

  clear() {
    emit(null);
  }
}
