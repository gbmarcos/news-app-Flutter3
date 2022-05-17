import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/local_storage/client.dart';
import 'package:news_app/state_management/article_cubit.dart';
import 'package:news_app/state_management/loading_more_state_cubit.dart';
import 'package:news_app/user_interface/pages/favorite_page.dart';
import 'package:news_app/user_interface/pages/feed_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedTab;

  @override
  void initState() {
    //start with first page into tabs
    selectedTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeTransition(
              opacity: primaryAnimation,
              child: child,
            );
          },
          child: getPage()),
      extendBody: true,
      bottomNavigationBar: Material(
        elevation: 10,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          currentIndex: selectedTab,
          onTap: (int value) {
            setState(() {
              selectedTab = value;
            });
          },
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          fixedColor: Color(0xFF111827),
          selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          items: [
            BottomNavigationBarItem(
              label: 'Feed',
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Favorites',
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }

  getPage() {
    switch (selectedTab) {
      case 0:
        return MultiBlocProvider(
          key: ValueKey<String>("FeedPage"),
          providers: [
            BlocProvider(
              create: (context) => ArticleCubit()..loadArticles(),
            ),
            BlocProvider(
              create: (context) => LoadingMoreStateCubit(),
            ),
          ],
          child: FeedPage(),
        );
      case 1:
        return MultiBlocProvider(
          key: ValueKey<String>("FavoritePage"),
          providers: [
            BlocProvider(
              create: (context) => ArticleCubit()
                ..loadArticles(
                  favoriteIdList: favoriteArticleBox.keys.toList(),
                ),
            ),
            BlocProvider(
              create: (context) => LoadingMoreStateCubit(),
            ),
          ],
          child: FavoritePage(),
        );
    }
  }
}
