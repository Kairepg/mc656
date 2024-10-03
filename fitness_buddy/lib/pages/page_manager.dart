import 'package:fitness_buddy/pages/activity/activity_page.dart';
import 'package:fitness_buddy/pages/favorite/favorite_page.dart';
import 'package:fitness_buddy/pages/home/home_page.dart';
import 'package:fitness_buddy/pages/page_manager_view.dart';
import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:fitness_buddy/pages/ranking/ranking_page.dart';
import 'package:flutter/material.dart';

class PageManager extends StatefulWidget {
  final int initialPage;

  const PageManager({super.key, this.initialPage = 0});

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialPage;
  }

  final List<String> _childrenText = const <String>[
    'Home',
    'Atividades',
    'Ranking',
    'Favorito',
    'Perfil',
  ];

  final List<Widget> _children = const <Widget>[
    HomePage(),
    ActivityPage(),
    RankingPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Atualiza o índice quando uma aba é selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(
        title: _childrenText[_currentIndex],
      ),
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: MainBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
