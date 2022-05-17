import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:news_app/src/common/data/repositories/article_repository.dart';
import 'package:news_app/src/common/domain/article/article.dart';
import 'package:news_app/src/common/services/local_storage/hive_service.dart';
import 'package:news_app/src/state_management/article_cubit.dart';
import 'package:news_app/src/state_management/loading_more_state_cubit.dart';
import 'package:news_app/src/user_interface/widgets/article_card.dart';
import 'package:news_app/src/user_interface/widgets/empty_list_widget.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late bool searching;
  late Duration transitionDuration;
  late Curve transitionCurve;
  late TextEditingController searchController;
  String lastSearchQuery = "";

  @override
  void initState() {
    searching = false;
    transitionDuration = Duration(milliseconds: 250);
    transitionCurve = Curves.decelerate;
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = searching ? "Search" : "Favorites";
    String titleKey = searching ? "title2" : "title1";

    TextStyle titleStyle = TextStyle(fontSize: 18);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: AppBar(
              title: AnimatedSwitcher(
                duration: transitionDuration,
                switchInCurve: transitionCurve,
                switchOutCurve: transitionCurve,
                layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                    alignment: Alignment.topLeft,
                  );
                },
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  key: ValueKey<String>(titleKey),
                  style: titleStyle,
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: transitionDuration,
                    switchInCurve: transitionCurve,
                    switchOutCurve: transitionCurve,
                    transitionBuilder: (child, animation) {
                      return FadeScaleTransition(
                        child: child,
                        animation: animation,
                      );
                    },
                    child: searching
                        ? Icon(
                            Icons.close,
                            key: ValueKey<String>("icon2"),
                          )
                        : Icon(
                            Icons.search,
                            key: ValueKey<String>("icon1"),
                          ),
                  ),
                  onPressed: () {
                    if (searching) {
                      searchController.clear();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (lastSearchQuery.isNotEmpty) {
                        lastSearchQuery = "";
                        reloadArticles();
                      }
                    }
                    setState(() {
                      searching = !searching;
                    });
                  },
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                )
              ],
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            clipBehavior: Clip.none,
            height: searching ? 70 : 0,
            duration: transitionDuration,
            curve: transitionCurve,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white.withOpacity(0.8),
                    cursorWidth: 1,
                    cursorHeight: 18,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (contains) {
                      lastSearchQuery = contains;
                      reloadArticles();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      fillColor: Colors.black.withOpacity(0.3),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: BlocBuilder<ArticleCubit, ArticleListMonad>(
                    builder: (context, data) {
                      return data.fold(
                        (error) {
                          return error.when(
                            (message, statusCode, response, stackTrace) => Center(
                              child: UnknownErrorWidget(),
                            ),
                            noDataException: () => Center(
                              child: AnimatedSwitcher(
                                duration: transitionDuration,
                                switchInCurve: transitionCurve,
                                switchOutCurve: transitionCurve,
                                child: searching ? EmptySearchWidget() : EmptyFavoriteListWidget(),
                              ),
                            ),
                            loadingDataException: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        (articleList) => Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: AnimatedContainer(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                ),
                                duration: transitionDuration,
                                curve: transitionCurve,
                                height: searching ? 0 : 55,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Favorite articles",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              child: NotificationListener<ScrollUpdateNotification>(
                                child: ImplicitlyAnimatedReorderableList<Article>(
                                  areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
                                  // ArticleModel(id: -1) is addend to build the loading-more indicator widget at the end od the list
                                  items: articleList + [Article(id: -1)],
                                  onReorderFinished: (item, from, to, newItems) {},
                                  padding: EdgeInsets.only(top: 16, bottom: 60),
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (
                                    context,
                                    animation,
                                    article,
                                    i,
                                  ) {
                                    // loading-more indicator widget is built if the id is -1
                                    if (article.id == -1) {
                                      return Reorderable(
                                        key: ValueKey<int>(article.id!),
                                        child: SizeFadeTransition(
                                          animation: animation,
                                          sizeFraction: 0.7,
                                          curve: Curves.easeInOut,
                                          child: loadingWidget(),
                                        ),
                                      );
                                    }
                                    return Reorderable(
                                      key: ValueKey<int>(article.id!),
                                      child: SizeFadeTransition(
                                        animation: animation,
                                        sizeFraction: 0.7,
                                        curve: Curves.easeInOut,
                                        child: ArticleCard(
                                          article: article,
                                          customizedFavoriteChangeFunction: () {
                                            context.read<ArticleCubit>().removeArticle(article.id!);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                onNotification: (ScrollUpdateNotification notification) {
                                  // loadMoreArticles() function is called if the Scrollable has less than 40 pixels left to reach the end
                                  var metrics = notification.metrics;
                                  if (metrics.extentAfter < 40 && metrics.pixels != 0) {
                                    loadMoreArticles();
                                  }
                                  return true;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              onRefresh: () async {
                if (searching) {
                  searchController.text = lastSearchQuery;
                }
                await reloadArticles();
              },
            ),
          ),
        ],
      ),
    );
  }

  // loading indicator displayed at de end of the list when loadMoreArticles() is called
  Widget loadingWidget() {
    return BlocBuilder<LoadingMoreStateCubit, bool>(
      builder: (context, loading) {
        return loading
            ? ProfileShimmer(
                isDisabledAvatar: true,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  Theme.of(context).primaryColor.withOpacity(0.3),
                  Theme.of(context).primaryColor.withOpacity(0.1),
                ],
                hasCustomColors: true,
              )
            : Container();
      },
    );
  }

  Future<void> reloadArticles() async {
    var articleCubit = context.read<ArticleCubit>();
    articleCubit.clear();
    await articleCubit.loadArticles(
      contains: lastSearchQuery,
      favoriteIdList: favoriteArticleBox.keys.toList(),
    );
  }

  Future<void> loadMoreArticles() async {
    var loadingMoreStateCubit = context.read<LoadingMoreStateCubit>();
    if (!loadingMoreStateCubit.state) {
      loadingMoreStateCubit.startLoading();
      await context.read<ArticleCubit>().loadMoreArticles(
            contains: lastSearchQuery,
            favoriteIdList: favoriteArticleBox.keys.toList(),
          );
      loadingMoreStateCubit.finishLoading();
    }
  }
}
