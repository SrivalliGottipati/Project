import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

final Set<dynamic> likedsett = {};
final Set<dynamic> followedsett = {};
List<dynamic> users = [];
Map<String, dynamic> liked_users = {};
Map<String, dynamic> followed_users = {};
Map<String, dynamic> sourcesData = {};

class CardsWithAPI extends StatefulWidget {
  const CardsWithAPI({super.key, required this.value});
  final String value;
  @override
  State<CardsWithAPI> createState() => _CardsWithAPIState();
}

class _CardsWithAPIState extends State<CardsWithAPI> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.wait([fetchSourcesData(), gettr(widget.value)]).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : users.isEmpty
            ? const Center(child: Text('No data available'))
            : ListOfCards(users: users);
  }

  Future<void> fetchSourcesData() async {
    const String url =
        'https://newsapi.org/v2/top-headlines/sources?apiKey=c5c9dfe1d21245f5bcf1d191d176b537';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'ok') {
          sourcesData = {
            for (var source in json['sources']) source['id']: source
          };
        }
      }
    } catch (e) {
      print('Error fetching sources: $e');
    }
    print('Sources data fetched: ${sourcesData.length} sources');
  }

  ///everything?q=apple&from=2024-07-25&to=2024-07-25&sortBy=popularity&apiKey
  // &pageSize=5  &category=business
  // https://newsapi.org/v2/top-headlines?country=in&apiKey=d94934e31d8d41c5a76653b69b024163
  //sources = https://newsapi.org/v2/top-headlines/sources?apiKey=d94934e31d8d41c5a76653b69b024163
  Future<void> gettr(String value) async {
    final String url =
        'https://newsapi.org/v2/everything?q=$value&apiKey=c5c9dfe1d21245f5bcf1d191d176b537&pageSize=10'; // Limit to 10 articles
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          users = (json['articles'] as List<dynamic>).where((article) {
            final sourceId = article['source']['id'];
            final sourceName = article['source']['name'];
            return sourceId != null && sourceName != "[Removed]";
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching articles: $e');
    }
  }

  ListView ListOfCards({required users}) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];

          return InkWell(
            onTap: () {
              print('Tapped');
            },
            child: cardCreate(context,
                title: user['title'] ?? 'No Title',
                description: user['description'] ?? 'No Description',
                author: user['source']['name'] ?? 'No Author',
                img_url:
                    user['urlToImage'] ?? 'https://via.placeholder.com/150',
                time: user['publishedAt'] ?? 'Null',
                url: user['url'] ?? 'Null',
                likedsett: likedsett,
                followedsett: followedsett,
                user: user),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            indent: 10,
            endIndent: 10,
          );
        },
        itemCount: users.length);
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
