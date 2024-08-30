import 'package:flutter/material.dart';
import 'package:trendview2/Frostedglass.dart';
import 'package:trendview2/searchscreen.dart';
import 'package:trendview2/tabsrab.dart';
import 'bookmarkscreen.dart';
import 'homescreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchAPI(),
    const BookmarkScreen(),
    const Tabs(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(child: _pages[_selectedIndex]),
            Positioned(
              left: 20,
              right: 20,
              bottom: 7,
              child: FrostedGlassBox(
                theHeight: 60.0,
                theWidth: MediaQuery.of(context).size.width * 80,
                theChild: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        icon: Icons.home_filled,
                        index: 0,
                      ),
                      _buildNavItem(
                        icon: Icons.saved_search_sharp,
                        index: 1,
                      ),
                      _buildNavItem(
                        icon: Icons.bookmarks_rounded,
                        index: 2,
                      ),
                      _buildNavItem(
                        icon: Icons.category_rounded,
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => _onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
