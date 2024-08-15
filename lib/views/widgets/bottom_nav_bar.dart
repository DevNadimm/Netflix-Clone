import 'package:flutter/material.dart';
import 'package:netflix_clone/views/screens/home_screen.dart';
import 'package:netflix_clone/views/screens/more_screen.dart';
import 'package:netflix_clone/views/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: _BottomNavigationBar(),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabs: [
          _TabItem(icon: Icons.home_rounded, label: 'Home'),
          _TabItem(icon: Icons.search_rounded, label: 'Search'),
          _TabItem(icon: Icons.photo_library_rounded, label: 'New & Hot'),
        ],
        indicator: const BoxDecoration(),
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.red,
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TabItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(icon),
      text: label,
    );
  }
}
