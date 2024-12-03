import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final Function(int) _onTabTapped;
  final int currentIndex;

  const MainBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required Function(int) onTabTapped,
  }) : _onTabTapped = onTabTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workouts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard),
          label: 'Ranking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorito',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: currentIndex, // Set the initial index
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: _onTabTapped,
    );
  }
}

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarHome({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height*0.16,
      leadingWidth: 100,
      foregroundColor: Colors.white,
      title: Card(
        elevation: 0,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.60,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/logo_images/logo.png',
          height: 50,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(150); // Define a altura da AppBar
}
