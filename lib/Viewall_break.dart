import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:trendview2/cardswithapi.dart';

List<dynamic> BreakingUsers = [];
Map<String, dynamic> sourcesData = {};

class BreakPage extends StatefulWidget {
  const BreakPage({super.key});

  @override
  State<BreakPage> createState() => _BreakPageState();
}

class _BreakPageState extends State<BreakPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: const Stack(
        children: [
          // Background Image

          // Column to hold the header and the scrollable content
          Column(
            children: [
              // Custom App Bar with back arrow and title

              // Expanded widget for the scrollable content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: CardsWithAPI2(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardsWithAPI2 extends StatefulWidget {
  const CardsWithAPI2({super.key});

  @override
  State<CardsWithAPI2> createState() => _CardsWithAPI2State();
}

class _CardsWithAPI2State extends State<CardsWithAPI2> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.wait([gettr2()]).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : BreakingUsers.isEmpty
            ? const Center(child: Text('No data available'))
            : ListOfCards(users: BreakingUsers);
  }

  ///everything?q=apple&from=2024-07-25&to=2024-07-25&sortBy=popularity&apiKey
  // &pageSize=5  &category=business
  // https://newsapi.org/v2/top-headlines?country=in&apiKey=d94934e31d8d41c5a76653b69b024163
  //sources = https://newsapi.org/v2/top-headlines/sources?apiKey=d94934e31d8d41c5a76653b69b024163
  Future<void> gettr2() async {
    const String url =
        'https://newsapi.org/v2/top-headlines?language=en&from=2024-08-23&to=2024-08-25&sortBy=publishedAt&apiKey=1ff6b6d53d834ec9b98b1374caed251f';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          BreakingUsers = (json['articles'] as List<dynamic>).where((article) {
            final sourceId = article['source']['id'];
            final sourceName = article['source']['name'];
            return sourceId != null;
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching articles: $e');
    }
  }

  ListView ListOfCards({required users}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final userr = users[index];

          return InkWell(
            onTap: () {
              print('Tapped');
            },
            child: cardCreate(context,
                title: userr['title'] ?? 'No Title',
                description: userr['description'] ?? 'No Description',
                author: userr['source']['name'] ?? 'No Author',
                img_url:
                    userr['urlToImage'] ?? 'https://via.placeholder.com/150',
                time: userr['publishedAt'] ?? 'Null',
                url: userr['url'] ?? 'Null',
                likedsett: likedsett,
                followedsett: followedsett,
                user: userr),
          );
        },
        // separatorBuilder: (BuildContext context, int index) {
        //   return Divider(
        //     indent: 10,
        //     endIndent: 10,
        //   );
        // },
        itemCount: BreakingUsers.length);
  }

  void navigateToWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  Widget cardCreate(
    BuildContext context, {
    required String title,
    required String description,
    required String author,
    required String img_url,
    required String time,
    required String url,
    required Set<dynamic> likedsett,
    required Set<dynamic> followedsett,
    required user,
    String? value,
  }) {
    String formattedTime = 'Null';
    if (time != 'Null') {
      DateTime dateTime = DateTime.parse(time);
      formattedTime = DateFormat('MMMM d, y HH:mm').format(dateTime);
    }

    double cardHeight = MediaQuery.of(context).size.height * 0.48;
    double cardWidth = MediaQuery.of(context).size.width * 0.95;

    return GestureDetector(
      onTap: () => navigateToWebView(url),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GlassmorphicContainer(
          height: cardHeight,
          width: cardWidth,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
                // Image Container
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
                  child: Container(
                    height: cardHeight * 0.45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(17)),
                      image: DecorationImage(
                        image: NetworkImage(img_url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // Title and Description
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    // Description
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Author and Time, Bookmark, Follow Container
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GlassmorphicContainer(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.9,
                  borderRadius: 10,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                author,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                formattedTime,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            icon: followedsett.contains(user['source']['id'])
                                ? const Icon(Icons.add_circle)
                                : const Icon(Icons.add_circle_outline),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                //START HERE
                                final sourceId = user['source']['id'];
                                if (sourceId != null) {
                                  if (followedsett.contains(sourceId)) {
                                    followedsett.remove(sourceId);
                                    followed_users.remove(sourceId);
                                  } else {
                                    followedsett.add(sourceId);
                                    //CHANGE THIS
                                    followed_users[sourceId] =
                                        sourcesData[sourceId];
                                  }
                                }
                                print('followed set = $followedsett');
                                print('followed_users = $followed_users');
                              });
                            },
                          ),
                          IconButton(
                            icon: likedsett.contains(url)
                                ? const Icon(Icons.bookmark)
                                : const Icon(Icons.bookmark_border),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                if (likedsett.contains(url)) {
                                  likedsett.remove(url);
                                  liked_users.remove(url);
                                } else {
                                  likedsett.add(url);
                                  liked_users[url] = user;
                                }

                                print("likedset = $likedsett");
                                print("liked_users = $liked_users");
                                //END HERE
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
        initialSettings: InAppWebViewSettings(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        onWebViewCreated: (InAppWebViewController controller) {},
        onLoadStart: (InAppWebViewController controller, Uri? url) {},
        onLoadStop: (InAppWebViewController controller, Uri? url) async {},
        onReceivedError: (InAppWebViewController controller,
            WebResourceRequest request, WebResourceError error) {
          // Handle the error
          print('Error: ${error.description}');
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
