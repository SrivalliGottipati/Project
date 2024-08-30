import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:trendview2/cardswithapi.dart';

// Existing sets for liked and followed items

final Map<String, dynamic> sourcesData =
    {}; // Ensure this is populated with the relevant data

class ApiTabView extends StatefulWidget {
  const ApiTabView({super.key, required this.category});
  final String category;

  @override
  State<ApiTabView> createState() => _ApiTabViewState();
}

class _ApiTabViewState extends State<ApiTabView> {
  List<dynamic> users = [];
  Set<String> userTitles = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    gettr(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListOfCards(users: users);
  }

  Future<void> gettr(String category) async {
    try {
      final String url =
          'https://newsapi.org/v2/everything?q=$category&language=en&from=2024-08-15&to=2024-08-25&searchIn=title&sortBy=publishedAt&apiKey=c5c9dfe1d21245f5bcf1d191d176b537';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          json['articles'].forEach((article) {
            final title = article['title'];
            if (title != null &&
                article['source']['id'] != null &&
                article['source']['name'] != "[Removed]" &&
                article['source']['name'] != null &&
                !userTitles.contains(title)) {
              users.add(article);
              userTitles.add(title);
            }
          });
          isLoading = false;
        });
      } else {
        print('Failed to load data');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  Widget ListOfCards({required List<dynamic> users}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final user = users[index];
        return cardCreate(
          context,
          title: user['title'] ?? 'No Title',
          description: user['description'] ?? 'No Description',
          author: user['author'] ?? 'No Author',
          img_url: user['urlToImage'] ?? 'https://via.placeholder.com/150',
          time: user['publishedAt'] ?? 'Null',
          url: user['url'] ?? 'Null',
          likedset: likedsett,
          followedset: followedsett,
          user: user,
        );
      },
      itemCount: users.length,
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
    required Set<dynamic> likedset,
    required Set<dynamic> followedset,
    required dynamic user,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: url),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      img_url,
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  title: Text(
                    limitWords(title, 5),
                    maxLines: 2,
                    style: const TextStyle(
                      fontFamily: 'FormaDJRMicro',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  subtitle: Text(
                    limitWords(description, 5),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: Wrap(
                    spacing: 5,
                    children: <Widget>[
                      IconButton(
                        icon: followedsett.contains(user['source']['id'])
                            ? const Icon(Icons.add_circle)
                            : const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() {
                            final sourceId = user['source']['id'];
                            if (sourceId != null) {
                              if (followedsett.contains(sourceId)) {
                                followedsett.remove(sourceId);
                                followed_users.remove(sourceId);
                              } else {
                                followedsett.add(sourceId);
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String limitWords(String text, int maxWords) {
    final words = text.split(' ');
    if (words.length <= maxWords) {
      return text;
    } else {
      return '${words.take(maxWords).join(' ')}...';
    }
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
          print('Error: ${error.description}');
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
