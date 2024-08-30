import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:ui';

class ApiCardScreen extends StatefulWidget {
  final String url;

  const ApiCardScreen({super.key, required this.url});

  @override
  _ApiCardScreenState createState() => _ApiCardScreenState();
}

class _ApiCardScreenState extends State<ApiCardScreen> {
  List<dynamic> apiContent = [];
  Set<int> bookmarkSet = {};

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  Future<void> fetchApiData() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['articles'];
        setState(() {
          apiContent = data
              .where((item) =>
                  item['urlToImage'] != null && item['urlToImage'].isNotEmpty)
              .toList();
        });
      } else {
        throw Exception('Failed to load API content');
      }
    } catch (e) {
      print('Error: $e');
      // Optionally, show a user-friendly error message here
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

  Widget cardCreate(
    BuildContext context, {
    required String title,
    required String description,
    required String author,
    required String img_url,
    required String content_url,
    required String time,
    required int index,
    required Set<int> sett,
    String? url,
  }) {
    return GestureDetector(
      onTap: () => navigateToWebView(content_url),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GlassmorphicContainer(
          height: MediaQuery.of(context).size.height * 0.37,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(30),
          //   color: Color(0xFF5A5859),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Image.network(
                        img_url,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  limitWords(title, 4),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 18.0,
                    left: 18,
                    right: 18,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF484848),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  author,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Text(
                                time,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: sett.contains(index)
                              ? const Icon(Icons.bookmark_border)
                              : const Icon(Icons.bookmark),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              sett.contains(index)
                                  ? sett.remove(index)
                                  : sett.add(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSmallCard(BuildContext context, dynamic content, int index) {
    return GestureDetector(
      onTap: () => navigateToWebView(content['url'] ?? ''),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0), // Adjust as needed
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10.0, sigmaY: 10.0), // Adjust blur effect as needed
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), // Semi-transparent color
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.white
                      .withOpacity(0.3), // Border color for better glass effect
                  width: 1.5,
                ),
              ),
              child: Card(
                color: Colors
                    .transparent, // Make Card transparent to see the glass effect
                elevation: 0,
                child: ListTile(
                  leading: Image.network(
                    content['urlToImage'] ?? '',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(
                    limitWords(
                        content['title'] ?? '', 4), // Limit title to 4 words
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    limitWords(content['description'] ?? '',
                        4), // Limit description to 4 words
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: bookmarkSet.contains(index)
                            ? const Icon(Icons.bookmark, color: Colors.white)
                            : const Icon(Icons.bookmark_border,
                                color: Colors.white),
                        onPressed: () {
                          setState(() {
                            bookmarkSet.contains(index)
                                ? bookmarkSet.remove(index)
                                : bookmarkSet.add(index);
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

  Widget buildSmallCardNew(BuildContext context, dynamic content, int index) {
    return GestureDetector(
      onTap: () => navigateToWebView(content['url'] ?? ''),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0), // Adjust as needed
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10.0, sigmaY: 10.0), // Adjust blur effect as needed
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), // Semi-transparent color
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.white
                      .withOpacity(0.3), // Border color for better glass effect
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      content['urlToImage'] ?? '',
                      fit: BoxFit.cover,
                      width: 150,
                      height: 145, // Adjusted image height to prevent overflow
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      limitWords(
                          content['title'] ?? '', 3), // Limit title to 3 words
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      limitWords(content['description'] ?? '',
                          4), // Limit description to 4 words
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline,
                              color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: bookmarkSet.contains(index)
                              ? const Icon(Icons.bookmark, color: Colors.white)
                              : const Icon(Icons.bookmark_border,
                                  color: Colors.white),
                          onPressed: () {
                            setState(() {
                              bookmarkSet.contains(index)
                                  ? bookmarkSet.remove(index)
                                  : bookmarkSet.add(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String limitWords(String text, int wordLimit) {
    List<String> words = text.split(' ');
    if (words.length <= wordLimit) {
      return text;
    } else {
      return '${words.take(wordLimit).join(' ')}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter the API content to include only items with a valid urlToImage
    List validApiContent = apiContent
        .where((item) =>
            item['urlToImage'] != null &&
            item['title'] != null &&
            item['description'] != null &&
            item['author'] != null &&
            item['url'] != null &&
            item['publishedAt'] != null)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Cards'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/blurr_greenlight.jpeg', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          // Ensure the background covers the entire screen height
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Ensure that there is at least one big card
                      if (validApiContent.isNotEmpty)
                        cardCreate(
                          context,
                          title: validApiContent[0]['title'],
                          description: validApiContent[0]['description'],
                          author: validApiContent[0]['author'],
                          img_url: validApiContent[0]['urlToImage'],
                          content_url: validApiContent[0]['url'],
                          time: validApiContent[0]['publishedAt'],
                          index: 0,
                          sett: bookmarkSet,
                        ),

                      // Space between big card and small cards
                      const SizedBox(height: 10),

                      // Ensure at least the first 5 small cards are displayed
                      if (validApiContent.length > 1)
                        SizedBox(
                          height: 302, // Adjusted height to ensure no overflow
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: validApiContent.length - 1 > 5
                                ? 5
                                : validApiContent.length - 1,
                            itemBuilder: (context, index) {
                              var item = validApiContent[index + 1];
                              return buildSmallCardNew(
                                  context, item, index + 1);
                            },
                          ),
                        ),

                      // Display the remaining small cards in a vertical list if present
                      if (validApiContent.length > 6)
                        Column(
                          children: validApiContent
                              .skip(6)
                              .map((item) => buildSmallCard(
                                  context, item, validApiContent.indexOf(item)))
                              .toList(),
                        ),

                      // Handle any remaining cards that were not included in the above sections
                      if (validApiContent.length <= 6 &&
                          validApiContent.length > 1)
                        Column(
                          children: validApiContent
                              .skip(1) // Skip the first big card
                              .map((item) => buildSmallCard(
                                  context, item, validApiContent.indexOf(item)))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
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
