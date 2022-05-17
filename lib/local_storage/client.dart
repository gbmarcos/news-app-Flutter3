
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

//local storage settings for favorite articles
const String FAVORITE_ARTICLE_BOX_NAME = 'myFavoriteArticleBox';
var favoriteArticleBox = Hive.box(FAVORITE_ARTICLE_BOX_NAME);