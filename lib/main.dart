import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:news_app/src/user_interface/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routemaster/routemaster.dart';

import 'src/common/services/local_storage/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  await Hive.openBox(FAVORITE_ARTICLE_BOX_NAME);

  runApp(MyApp());
}

final routes = RouteMap(
  routes: {
    '/': (_) => MaterialPage(child: HomePage()),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    preloadAssetsImages(context);

    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.teal,
        ),
        primaryColor: Colors.teal,
        fontFamily: "IBMPlexSans",
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.teal,
        ),
      ),
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
      routeInformationParser: RoutemasterParser(),
    );
  }

  void preloadAssetsImages(BuildContext context) {
    precacheImage(
      AssetImage(
        "assets/placeholder_2.jpg",
      ),
      context,
    );
    precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        'assets/favorite_icon.svg',
      ),
      context,
    );
    precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        'assets/news_icon.svg',
      ),
      context,
    );
    precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        'assets/search_icon.svg',
      ),
      context,
    );
    precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        'assets/error_icon.svg',
      ),
      context,
    );
  }
}
