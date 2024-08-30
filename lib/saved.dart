import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:trendview2/cardswithapi.dart';
import 'package:trendview2/searchscreen.dart';

Set<String> total_set = {};
Map<String, dynamic> total_data = {};

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  bool _isBookmarked = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _isBookmarked = !_isBookmarked;
      });
    });

    setState(() {
      total_set = Set<String>.from(likedsett)..addAll(search_likedset);
      total_data = Map<String, dynamic>.from(liked_users)
        ..addAll(search_likedusers);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void navigateToWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(total_set);
    print(total_data);

    return Scaffold(
      backgroundColor: const Color(0xFF4D4C4D),
      body: Stack(
        children: [
          // Background Image
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/blurr_greenlight.jpeg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Column(
            children: [
              if (total_set.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          child: Icon(
                            _isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 100,
                            color: const Color.fromARGB(205, 219, 225, 227),
                          ).animate().scale(duration: 600.ms).then().move(),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Saved bookmarks will appear here.',
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
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final key = total_set.elementAt(index);
                      if (!total_data.containsKey(key)) {
                        return const SizedBox.shrink();
                      }
                      final title = total_data[key]['title'];
                      final author = total_data[key]['source']['name'];
                      final url = total_data[key]['url'];

                      return GestureDetector(
                        onTap: () => navigateToWebView(url),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 15),
                          title: Text(
                            title ?? 'No Title',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'FormaDJRMicro',
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          subtitle: Text(
                            author ?? 'No Author',
                            style: const TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 15,
                              color: Colors.white70,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: IconButton(
                            icon: total_set.contains(key)
                                ? const Icon(Icons.bookmark)
                                : const Icon(Icons.bookmark_border),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                if (likedsett.contains(key)) {
                                  likedsett.remove(key);
                                  liked_users.remove(key);
                                  total_data.remove(key);
                                  total_set.remove(key);
                                } else if (search_likedset.contains(key)) {
                                  search_likedset.remove(key);
                                  search_likedusers.remove(key);
                                  total_data.remove(key);
                                  total_set.remove(key);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.white,
                      );
                    },
                    itemCount: total_set.length,
                  ),
                ),
            ],
          ),
        ],
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
