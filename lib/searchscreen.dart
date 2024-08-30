import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_animate/flutter_animate.dart';

final Set<String> search_likedset = {};
List<dynamic> search_users = [];
Map<String, dynamic> search_likedusers = {};

class SearchAPI extends StatefulWidget {
  const SearchAPI({super.key});

  @override
  State<SearchAPI> createState() => _SearchAPIState();
}

class _SearchAPIState extends State<SearchAPI> {
  TextEditingController searchcontroller = TextEditingController();
  bool isLoading = false;

  Future<void> showItems(String value) async {
    if (value.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      final formattedValue =
          value.replaceAll(' ', '+'); // Replace space with '+'
      final url =
          'https://newsapi.org/v2/everything?q=$formattedValue&from=2024-08-15&to=2024-08-26&searchIn=title&sortBy=popularity&pageSize=10&apiKey=c5c9dfe1d21245f5bcf1d191d176b537';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        search_users = (json['articles'] as List<dynamic>).where((article) {
          final sourceName = article['source']['name'];
          final author = article['author'];
          return sourceName != "[Removed]" && author != "[Removed]";
        }).toList();
        isLoading = false;
      });
    }
  }

  void navigateToWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  void clearSearch() {
    setState(() {
      searchcontroller.clear();
      search_users = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(213, 42, 42, 42),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromARGB(205, 219, 225, 227),
                ),
                onPressed: () {
                  clearSearch();
                },
              ),
              pinned: true,
              expandedHeight: 140.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image.asset(
                    //   'assets/blurr_greenlight.jpeg',
                    //   fit: BoxFit.cover,
                    // ),
                    Container(
                      color: const Color(0xFF303030),
                    ),
                    Positioned(
                      bottom: 20.0,
                      left: 15.0,
                      right: 15.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: GlassmorphicContainer(
                              height: 55,
                              borderRadius: 20,
                              blur: 10,
                              border: 0,
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
                              width: double.infinity,
                              child: TextField(
                                controller: searchcontroller,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Enter search term...',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'FormaDJRMicro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(205, 219, 225, 227),
                                    height: 1,
                                    letterSpacing: -1,
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(192, 115, 146, 230),
                                        width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onSubmitted: (value) {
                                  showItems(value);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              showItems(searchcontroller.text);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(15),
                                iconColor:
                                    const Color.fromARGB(171, 255, 255, 255),
                                backgroundColor:
                                    const Color.fromARGB(103, 218, 218, 218),
                                elevation: 7),
                            child: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(height: 1, color: Color.fromARGB(0, 233, 28, 28)),
            ),
            isLoading
                ? const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : searchcontroller.text.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search,
                                      size: 100,
                                      color: Color.fromARGB(205, 219, 225, 227))
                                  .animate()
                                  .scale(duration: 600.ms)
                                  .then()
                                  .move(),
                              const Text(
                                'Please enter a search term',
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
                    : search_users.isEmpty
                        ? const SliverFillRemaining(
                            child: Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final searchSingleuser = search_users[index];
                                final String url =
                                    searchSingleuser['url'] ?? '';

                                return GestureDetector(
                                  onTap: () => navigateToWebView(url),
                                  child: GlassmorphicContainer(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    width: double.infinity,
                                    height: 150,
                                    borderRadius: 20,
                                    border: 2,
                                    blur: 10,
                                    linearGradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFFffffff)
                                            .withOpacity(0.1),
                                        const Color(0xFFFFFFFF)
                                            .withOpacity(0.1),
                                      ],
                                      stops: const [0.1, 1],
                                    ),
                                    borderGradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFFffffff)
                                            .withOpacity(0.5),
                                        const Color(0xFFFFFFFF)
                                            .withOpacity(0.5),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              searchSingleuser['title'] ??
                                                  'No Title',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontFamily: 'FormaDJRMicro',
                                                fontWeight: FontWeight.w800,
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  maxLines: 1,
                                                  searchSingleuser['author'] ??
                                                      'No Author',
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontSize: 15,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: Text(
                                                    searchSingleuser[
                                                            'description'] ??
                                                        'No Description',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'SF Pro Display',
                                                      fontSize: 15,
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 0,
                                          child: IconButton(
                                            icon: search_likedset.contains(url)
                                                ? const Icon(Icons.bookmark,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))
                                                : const Icon(
                                                    Icons.bookmark_border,
                                                    color: Color.fromARGB(
                                                        255, 255, 249, 249)),
                                            onPressed: () {
                                              setState(() {
                                                if (search_likedset
                                                    .contains(url)) {
                                                  search_likedset.remove(url);
                                                  search_likedusers.remove(url);
                                                } else {
                                                  search_likedset.add(url);
                                                  search_likedusers[url] =
                                                      searchSingleuser;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: search_users.length,
                            ),
                          ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 70),
            ),
          ],
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
