import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import 'package:news_app/models/article_model.dart';
import 'package:news_app/state_management/article_cubit.dart';
import 'package:news_app/state_management/loading_more_state_cubit.dart';
import 'package:news_app/user_interface/widgets/article_card.dart';
import 'package:news_app/user_interface/widgets/empty_list_widget.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
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
    String title = searching ? "Search" : "Feed";
    String titleKey = searching ? "title2" : "title1";
    String emptyListWidgetKey = searching ? "emptyListWidgetKey2" : "emptyListWidgetKey1";

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
                  child: BlocBuilder<ArticleCubit, List<ArticleModel>?>(
                    builder: (context, articleList) {
                      if (articleList == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (articleList.isEmpty) {
                        return Center(
                          child: AnimatedSwitcher(
                            duration: transitionDuration,
                            switchInCurve: transitionCurve,
                            switchOutCurve: transitionCurve,
                            child: searching
                                ? emptySearchListIndicator(emptyListWidgetKey)
                                : emptyArticleListIndicator(emptyListWidgetKey),
                          ),
                        );
                      }

                      return Column(
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
                                "News feed",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Expanded(
                            child: NotificationListener<ScrollUpdateNotification>(
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 10, bottom: 60),
                                physics: AlwaysScrollableScrollPhysics(),
                                // itemCount = articleList.length + 1 to build the loading-more indicator widget at the end of the list
                                itemCount: articleList.length + 1,
                                itemBuilder: (context, index) {
                                  // loading-more indicator widget is built at the last index
                                  if (index == articleList.length) {
                                    return loadingWidget();
                                  }
                                  return ArticleCard(
                                    article: articleList[index],
                                  );
                                },
                              ),
                              onNotification: (ScrollUpdateNotification notification) {
                                //para cargar más eventos al llegar al final de la lista
                                var metrics = notification.metrics;
                                if (metrics.extentAfter < 40 && metrics.pixels != 0) {
                                  loadMoreArticles();
                                }
                                return true;
                              },
                            ),
                          ),
                        ],
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
    );
  }

  Future<void> loadMoreArticles() async {
    var loadingMoreStateCubit = context.read<LoadingMoreStateCubit>();
    if (!loadingMoreStateCubit.state) {
      loadingMoreStateCubit.startLoading();
      await context.read<ArticleCubit>().loadMoreArticles(
            contains: lastSearchQuery,
          );
      loadingMoreStateCubit.finishLoading();
    }
  }

  //widget displayed when search result is empty
  Widget emptySearchListIndicator(String emptyListWidgetKey) {
    return EmptyListWidget(
      key: ValueKey<String>(emptyListWidgetKey),
      svgPath: "assets/search_icon.svg",
      text: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "There are no results for this search.",
            style: TextStyle(color: Color(0xFF1F2937), fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            " Try searching another word.",
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  //widget displayed when article list is empty
  Widget emptyArticleListIndicator(String emptyListWidgetKey) {
    return EmptyListWidget(
      key: ValueKey<String>(emptyListWidgetKey),
      svgPath: "assets/news_icon.svg",
      text: Text(
        "There is no news yet",
        style: TextStyle(color: Color(0xFF1F2937), fontSize: 14),
      ),
    );
  }
}
