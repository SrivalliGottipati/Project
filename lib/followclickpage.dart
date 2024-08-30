import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trendview2/cardswithapi.dart';

List<dynamic> usersss = [];

class FollowClickPage2 extends StatefulWidget {
  final String id;
  const FollowClickPage2({super.key, required this.id});

  @override
  State<FollowClickPage2> createState() => _FollowClickPage2State();
}

class _FollowClickPage2State extends State<FollowClickPage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettr(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print(usersss);
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF4D4C4D),
          appBar: AppBar(
              backgroundColor: const Color(0xFF303030),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(205, 219, 225, 227),
                  ))),
          body: usersss.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final user1 = usersss[index];

                    return InkWell(
                      onTap: () {
                        print('Tapped');
                      },
                      child: cardCreate(context,
                          title: user1['title'] ?? 'No Title',
                          description: user1['description'] ?? 'No Description',
                          author: user1['source']['name'] ?? 'No Author',
                          img_url: user1['urlToImage'] ??
                              'https://via.placeholder.com/150',
                          time: user1['publishedAt'] ?? 'Null',
                          url: user1['url'] ?? 'Null',
                          likedsett: likedsett,
                          followedsett: followedsett,
                          user: user1),
                    );
                  },
                  itemCount: 5)),
    );
  }

  Future<void> gettr(String value) async {
    print('gettr called');
    final String url =
        'https://newsapi.org/v2/top-headlines?sources=$value&from=2024-07-18&to2024-07-29&sortBy=publishedAt&apiKey=c5c9dfe1d21245f5bcf1d191d176b537';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      usersss = json['articles'];
    });
    print('gettr completed');
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
      formattedTime = DateFormat('MMMM d, y').format(dateTime);
    }

    return GestureDetector(
      onTap: () => navigateToWebView(url),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GlassmorphicContainer(
          height: MediaQuery.of(context).size.height * 0.5,
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
                    height: MediaQuery.of(context).size.height * 0.25,
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
              Expanded(
                child: Padding(
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
                        maxLines: 3,
                        style: const TextStyle(
                          fontFamily: 'FormaDJRMicro',
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          height: 1,
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
                              fontFamily: 'SF Pro Display',
                              fontSize: 15,
                              color: Colors.white70,
                              fontWeight: FontWeight.w300,
                              height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Author and Time
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            author,
                            style: const TextStyle(
                              fontFamily: 'FormaDJRMicro',
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              color: Color.fromARGB(255, 255, 255, 255),
                              height: 1,
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: const TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          icon: followedsett.contains(user['source']['id'])
                              ? const Icon(Icons.add_circle)
                              : const Icon(Icons.add_circle_outline),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
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
                            });
                          },
                        ),
                      ],
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
