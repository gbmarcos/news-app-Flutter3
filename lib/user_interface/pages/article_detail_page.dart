import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:animations/animations.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:news_app/local_storage/client.dart';
import 'package:news_app/models/article_model.dart';

class ArticleDetailPage extends StatefulWidget {
  static const String routeName = "articleDetail";

  final ArticleModel article;
  final Function? additionalFavoriteChangeFunction;

  const ArticleDetailPage({
    Key? key,
    required this.article,
    this.additionalFavoriteChangeFunction,
  }) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Article",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFF111827),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColumnSuper(
              innerDistance: -20,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.article.imageUrl ?? "",
                  placeholder: (context, url) {
                    return Image.asset("assets/placeholder_2.jpg");
                  },
                ),
                Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.article.title ?? "-",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          height: 32,
                          color: Color(0xFFE5E7EB),
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              "By ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF374151),
                              ),
                            ),
                            Text(
                              widget.article.newsSite ?? "-",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF374151),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF6B7280),
                              size: 20,
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                              width: 10,
                            ),
                            Text(
                              widget.article.publishedAt != null
                                  ? DateFormat.yMMMMd('en_US').format(widget.article.publishedAt!)
                                  : "-",
                              style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                              width: 26,
                            ),
                            buildFavoriteButton()
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              color: Color(0xFFF8F9FA),
              child: Text(
                widget.article.summary ?? "-",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF374151),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFavoriteButton() {
    int? articleId = widget.article.id;
    return IconButton(
      icon: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: favoriteArticleBox.containsKey(articleId)
            ? Icon(
                Icons.favorite,
                key: ValueKey<bool>(true),
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.favorite_border,
                key: ValueKey<bool>(false),
                color: Color(0xFF6B7280),
              ),
        transitionBuilder: (child, animation) {
          return FadeScaleTransition(
            child: child,
            animation: animation,
          );
        },
      ),
      onPressed: () {
        if (favoriteArticleBox.containsKey(articleId)) {
          favoriteArticleBox.delete(articleId);
        } else {
          favoriteArticleBox.put(articleId, "");
        }
        setState(() {});

        widget.additionalFavoriteChangeFunction?.call();
      },
    );
  }
}
