import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:trendview2/cardswithapi.dart';

final Set<String> likedset = {};
final Set<String> followedset = {};
List<dynamic> users = [];

class listCards extends StatefulWidget {
  const listCards({super.key, required this.value});
  final String value;

  @override
  State<listCards> createState() => _CardsWithAPIState();
}

class _CardsWithAPIState extends State<listCards> {
  @override
  void initState() {
    super.initState();
    gettr(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return CardCreateMethod(context, user);
            },
          );
  }

  Widget CardCreateMethod(BuildContext context, user) {
    return cardCreate(context,
        title: user['title'] ?? 'No Title',
        description: user['description'] ?? 'No Description',
        author: user['author'] ?? 'No Author',
        img_url: user['urlToImage'] ?? 'https://via.placeholder.com/150',
        time: user['publishedAt'] ?? 'Null',
        url: user['url'] ?? 'Null',
        likedset: likedset,
        followedset: followedset,
        user: user);
  }

  Future<void> gettr(String value) async {
    try {
      final String url =
          'https://newsapi.org/v2/everything?q=$value&language=en&sortBy=publishedAt&from=2024-08-12&to=2024-08-26&apiKey=c5c9dfe1d21245f5bcf1d191d176b537';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          users = json['articles']
              .where((article) =>
                  article['source']['id'] != null &&
                  article['source']['name'] != "[Removed]" &&
                  article['source']['name'] != null)
              .toList();
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget cardCreate(
    BuildContext context, {
    required String title,
    required String description,
    required String author,
    required String img_url,
    required String time,
    required String url,
    required Set<String> likedset,
    required Set<String> followedset,
    required user,
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
                    style: const TextStyle(
                      fontFamily: 'FormaDJRMicro',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    limitWords(author, 5),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: Color.fromARGB(192, 255, 255, 255),
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
