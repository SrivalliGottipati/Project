import 'package:flutter/material.dart';
// For the TickerProvider
import 'package:trendview2/searchscreen.dart';
import 'package:trendview2/tabsrab.dart';

import 'bookmarkscreen.dart';
import 'login.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimating = false;
  bool _isFirstImage = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
    setState(() {
      _isAnimating = !_isAnimating;
      _isFirstImage = !_isFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth =
        MediaQuery.of(context).size.width * 0.9; // 90% of screen width
    double headerHeight = 230.0; // Height of the header

    return SizedBox(
      height: 400,
      //color: Colors.red,
      width: drawerWidth,
      child: Column(
        children: [
          // Custom Header Container
          Container(
            height: headerHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade600, Colors.white],
                  stops: const [0.75, 0.75], // Sharp transition
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: Colors.red),
            child: Stack(
              children: [
                // Profile image on the left side
                Positioned(
                  top: 100,
                  left: 16,
                  bottom: 0, // Adjust as needed
                  child: GestureDetector(
                    onTap: _toggleAnimation,
                    child: ClipOval(
                      child: Container(
                        color: Colors.red,
                        width: 100, // Width of the circle
                        height: 80, // Height of the circle
                        child: AnimatedSwitcher(
                          duration: const Duration(seconds: 2),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return RotationTransition(
                              turns: animation,
                              child: child,
                            );
                          },
                          child: _isFirstImage
                              ? Image.network(
                                  'https://tse2.mm.bing.net/th?id=OIP._-13sIWbvXVEG-QY-fbqvQHaJy&pid=Api&P=0&h=180', // Replace with your first image URL
                                  fit: BoxFit
                                      .cover, // Ensures the image fills the circle
                                  key: const ValueKey<int>(1),
                                )
                              : Image.network(
                                  'https://tse2.mm.bing.net/th?id=OIP._-13sIWbvXVEG-QY-fbqvQHaJy&pid=Api&P=0&h=180', // Replace with your second image URL
                                  fit: BoxFit
                                      .cover, // Ensures the image fills the circle
                                  key: const ValueKey<int>(2),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                // User details on the right side
                const Positioned(
                  left: 130, // Position the text to the right of the image
                  bottom: 56, // Adjust as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Background for the rest of the content
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text(
                        'user.email@example.com'), // Replace with user's email
                    onTap: () {
                      // Handle email section tap
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Tabs()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bookmark),
                    title: const Text('Bookmarks'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookmarkScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.search),
                    title: const Text('Search'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchAPI()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLogin()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
