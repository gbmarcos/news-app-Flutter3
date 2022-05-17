import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:news_app/api_service/repositories/article_repository.dart';
import 'package:news_app/common/exceptions.dart';

class ArticleCubit extends Cubit<ArticleListMonad> {
  //to perform lazy loading
  final int limit = 10;

  ArticleCubit() : super(Either.left(NetworkException.loadingDataException()));

  Future<void> loadArticles({String? contains, List? favoriteIdList}) async {
    //if favoriteIdList is a not null empty list, ArticleCubit emits a empty ArticleModel list
    if (favoriteIdList != null && favoriteIdList.isEmpty) {
      emit(Either.left(NetworkException.noDataException()));
      return;
    }

    final response = await ArticleRepository().getArticles(
      start: 0,
      limit: limit,
      contains: contains,
      favoriteIdList: favoriteIdList,
    );

    emit(response);
  }

  Future<void> loadMoreArticles({String? contains, List? favoriteIdList}) async {
    //if favoriteIdList is a not null empty list, ArticleCubit emits a empty ArticleModel list
    if (favoriteIdList != null && favoriteIdList.isEmpty) {
      emit(Either.left(NetworkException.noDataException()));
      return;
    }

    int start = state.fold((error) => 0, (list) => list.length);

    print("loading more");
    final response = await ArticleRepository().getArticles(
      start: start,
      limit: limit,
      contains: contains,
      favoriteIdList: favoriteIdList,
    );

    response.fold(
      (l) => emit(Either.left(l)),
      (newEventsList) {
        state.fold(
          (l) => emit(Either.right(newEventsList)),
          (currentEventList) => emit(
            Either.right([
              ...currentEventList,
              ...newEventsList,
            ]),
          ),
        );
      },
    );
  }

  void removeArticle(int id) {
    state.fold(
      (l) {},
      (list) {
        final newList = list.where((element) => element.id != id).toList();

        emit(newList.isEmpty
            ? Either.left(NetworkException.noDataException())
            : Either.right(newList));
      },
    );
  }

  clear() {
    emit(Either.left(NetworkException.loadingDataException()));
  }
}
