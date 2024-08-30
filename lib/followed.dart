import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:trendview2/cardswithapi.dart';
import 'package:http/http.dart' as http;
import 'package:trendview2/followclickpage.dart';

class Followed extends StatefulWidget {
  const Followed({super.key});

  @override
  State<Followed> createState() => _FollowedState();
}

class _FollowedState extends State<Followed> {
  Map<String, dynamic> sourceDetails = {}; // To store source details
  bool _isFollowed = false; // For bookmark animation

  @override
  void initState() {
    super.initState();
    fetchSourceDetails();
    _startFollowAnimation(); // Start the bookmark animation
  }

  Future<void> fetchSourceDetails() async {
    const String url =
        'https://newsapi.org/v2/top-headlines/sources?apiKey=d94934e31d8d41c5a76653b69b024163';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          // Store source details using source id as key
          sourceDetails = {
            for (var source in json['sources']) source['id']: source
          };
        });
      }
    } catch (e) {
      print('Error fetching source details: $e');
    }
  }

  void _startFollowAnimation() {
    // Set up a periodic timer to toggle the follow icon
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _isFollowed = !_isFollowed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4D4C4D),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: followed_users.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              child: Icon(
                                _isFollowed
                                    ? Icons.add_circle
                                    : Icons.add_circle_outline,
                                size: 100,
                                color: const Color.fromARGB(205, 219, 225, 227),
                              ).animate().scale(duration: 600.ms).then().move(),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Followed Channels will appear here.',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromARGB(205, 219, 225, 227),
                                height: 1,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: followed_users.length,
                        itemBuilder: (context, index) {
                          final sourceId = followed_users.keys.elementAt(index);
                          final source = sourceDetails[sourceId];
                          return source == null
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FollowSet(
                                    title: source['name'],
                                    description: source['description'],
                                    id: source['id'],
                                  ),
                                );
                        },
                      ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ],
      ),
    );
  }
}

class FollowSet extends StatefulWidget {
  final String title;
  final String description;
  final String id;

  const FollowSet({
    super.key,
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  State<FollowSet> createState() => _FollowSetState();
}

class _FollowSetState extends State<FollowSet> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      followCard(context,
          title: widget.title, description: widget.description, id: widget.id),
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: pages.length,
            itemBuilder: (BuildContext context, int index) {
              return pages[index % pages.length];
            },
          ),
        ],
      ),
    );
  }

  Widget followCard(BuildContext context,
      {required String title,
      required String description,
      required String id}) {
    return InkWell(
      onTap: () {
        FollowClickPageNav(context, widget.id);
      },
      child: GlassmorphicContainer(
        height: MediaQuery.of(context).size.height * 0.17,
        width: double.infinity,
        borderRadius: 20,
        border: 2,
        blur: 10,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.1),
            const Color(0xFFFFFFFF).withOpacity(0.1),
          ],
          stops: const [0.1, 1],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.5),
            const Color(0xFFFFFFFF).withOpacity(0.5),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'FormaDJRMicro',
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              height: 1,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: followedsett.contains(id)
                              ? const Icon(Icons.add_circle)
                              : const Icon(Icons.add_circle_outline),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              if (followedsett.contains(id)) {
                                followedsett.remove(id);
                                followed_users.remove(id);
                              } else {
                                followedsett.add(id);
                                followed_users[id] = sourcesData[id];
                              }
                              print('followed set = $followedsett');
                              print('followed_users = $followed_users');
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 15,
                        color: Colors.white70,
                        fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

FollowClickPageNav(BuildContext context, String id) {
  print(id);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FollowClickPage2(id: id),
    ),
  );
}
