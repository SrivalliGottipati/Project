// import 'package:flutter/material.dart';

// class CategoryViewAll extends StatefulWidget {
//   final String id;
//   const CategoryViewAll({super.key ,required this.id});

//   @override
//   State<CategoryViewAll> createState() => _CategoryViewAllState();
// }

// class _CategoryViewAllState extends State<CategoryViewAll> {
//   @override
//   Widget build(BuildContext context) {
//     print(widget.id);
//     return const Placeholder();
//   }
// }

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:trendview2/Frostedglass.dart';
import 'package:trendview2/cardswithapi.dart';

// ignore: must_be_immutable
class CategoryViewAll extends StatefulWidget {
  final String id;
  CategoryViewAll({super.key, required this.id});
  late String value;

  @override
  State<CategoryViewAll> createState() => _CategoryViewAllState();
}

class _CategoryViewAllState extends State<CategoryViewAll> {
  List<dynamic> articleList = [];
  List<String> randomInts = [];
  late String categoryId;

  @override
  void initState() {
    super.initState();
    categoryId = widget.id;
    home_gettr(categoryId);
  }

  Future<void> home_gettr(String value) async {
    try {
      final String url =
          'https://newsapi.org/v2/top-headlines?category=$value&language=en&apiKey=bed658a287ec4419a6eaead2b3737edb';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          articleList = (json['articles'] as List<dynamic>).where((article) {
            final sourceName = article['source']['name'];
            return sourceName != "[Removed]";
          }).toList();
          if (randomInts.isEmpty) {
            randomInts = List.generate(articleList.length, (index) {
              final randomInt = 50000 + Random().nextInt(80000 - 50000 + 1);
              final formatter = NumberFormat('#,###');
              return formatter.format(randomInt);
            });
            print('success');
            print(articleList);
          }
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4D4C4D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D4C4D),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(205, 219, 225, 227)),
        ),
        centerTitle: true,
        title: Text(
          capitalize(categoryId),
          style: TextStyle(
            fontFamily: 'FormaDJRMicro',
            fontWeight: FontWeight.bold,
            fontSize: 33,
            color: Color.fromARGB(205, 219, 225, 227),
            height: 1,
            letterSpacing: -1,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child:
                  HomeList(articleList: articleList, randomInts: randomInts)),
        ],
      ),
    );
  }

  Widget HomeList(
      {required List<dynamic> articleList, required List<String> randomInts}) {
    return ListView.builder(
      itemCount: articleList.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articleList[index];
        final randomInt = randomInts[index];
        return InkWell(
          onTap: () {
            print('Tapped');
          },
          child: HomeCard(
            title: article['title'] ?? 'No Title',
            description: article['description'] ?? 'No Description',
            author: article['source']['name'] ?? 'No Author',
            img_url: article['urlToImage'] ?? 'https://via.placeholder.com/150',
            time: article['publishedAt'] ?? 'Null',
            url: article['url'] ?? 'Null',
            likedsett: likedsett,
            followedsett: followedsett,
            user: article,
            randomInt: randomInt,
          ),
        );
      },
    );
  }

  void navigateToWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  Widget HomeCard({
    required String title,
    required String description,
    required String author,
    required String img_url,
    required String time,
    required String url,
    required Set<dynamic> likedsett,
    required Set<dynamic> followedsett,
    required user,
    required String randomInt, // Added parameter for random integer
  }) {
    String formattedTime = 'Null';
    if (time != 'Null') {
      DateTime dateTime = DateTime.parse(time);
      formattedTime = DateFormat('MMMM d, y HH:mm').format(dateTime);
    }

    return GestureDetector(
      onTap: () => navigateToWebView(url),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FrostedGlassBox(
              theHeight: 250.0,
              theWidth: double.infinity,
              theChild: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'FormaDJRMicro',
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Color.fromARGB(205, 219, 225, 227),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          author,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 15,
                            color: Color.fromARGB(205, 219, 225, 227),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 15,
                            color: Color.fromARGB(205, 219, 225, 227),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 223, 223, 223),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          color: Color.fromARGB(205, 219, 225, 227),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          randomInt, // Display the unique random integer
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 15,
                            color: Color.fromARGB(205, 219, 225, 227),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
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
                          icon: likedsett.contains(url)
                              ? const Icon(Icons.bookmark)
                              : const Icon(Icons.bookmark_border),
                          color: const Color.fromARGB(205, 219, 225, 227),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
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

String capitalize(String s) =>
    s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}' : s;
