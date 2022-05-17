import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListWidget extends StatelessWidget {
  final String svgPath;
  final Widget text;

  const EmptyListWidget({
    Key? key,
    required this.svgPath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 160,
          width: 160,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            svgPath,
            height: 60,
            width: 60,
            color: Color(0xFFD1D5DB),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF2F3F5),
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
        text,
      ],
    );
  }
}


class EmptyFavoriteListWidget extends StatelessWidget {
  const EmptyFavoriteListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyListWidget(
      key: ValueKey<String>('favoritePageKey'),
      svgPath: "assets/favorite_icon.svg",
      text: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You don't have favorites yet.",
            style: TextStyle(color: Color(0xFF1F2937), fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.transparent,
          ),
          RichText(
            textScaleFactor: 1.1,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Tap on the  ",
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                TextSpan(
                  text: "  to mark an article as a favortite.",
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyListWidget(
      key: ValueKey<String>('searchPageKey'),
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
}

class EmptyArticleListWidget extends StatelessWidget {
  const EmptyArticleListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  EmptyListWidget(
      key: ValueKey<String>('articlePageWidget'),
      svgPath: "assets/news_icon.svg",
      text: Text(
        "There is no news yet",
        style: TextStyle(color: Color(0xFF1F2937), fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class UnknownErrorWidget extends StatelessWidget {
  const UnknownErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  EmptyListWidget(
      key: ValueKey<String>('UnknownErrorWidget'),
      svgPath: "assets/error_icon.svg",
      text: Text(
        "Unknown Error",
        style: TextStyle(color: Color(0xFF1F2937), fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
