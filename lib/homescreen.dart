import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trendview2/breakinggetter.dart';
import 'package:trendview2/login.dart';
import 'Viewall_recom.dart';
import 'list_cards.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

List<dynamic> users = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double cardHeight = 114.44;
  final int numberOfCards = 20;
  List<dynamic> CarouselUsers = [];
  final CarouselController _carouselController = CarouselController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    carouselGettr();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF303030),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyLogin()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(205, 219, 225, 227),
            )),
        // actions: [

        //   InkWell(
        //           onTap: () {

        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(20),
        //               child: const FrostedGlassBox(
        //                 theHeight: 40.0,
        //                 theWidth: 40.0,
        //                 theChild: Padding(
        //                   padding: EdgeInsets.all(8.0),
        //                   child: Icon(Icons.restore, color: Color.fromARGB(205, 219, 225, 227)),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),],
      ),
      body: Stack(
        children: <Widget>[
          // Background Container with Gradient
          Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/Trippy Gradient Wallpaper.jpeg'),
            //     fit: BoxFit.cover, // This will cover the entire container
            //   ),
            // ),
            color: const Color.fromARGB(213, 42, 42, 42),
          ),
          // Back arrow icon at the top of the screen

          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top:
                            20.0), // Add padding to avoid collision with back arrow

                    child: Column(
                      children: [
                        // Container with "Breaking News" title and "View All" text
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Latest News',
                                style: TextStyle(
                                  fontFamily: 'FormaDJRMicro',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color: Color.fromARGB(205, 219, 225, 227),
                                  height: 1,
                                  letterSpacing: -1,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeGetter(),
                                    ),
                                  );
                                },
                                child: Container(
                                  color:
                                      const Color.fromARGB(192, 115, 146, 230),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(236, 255, 255, 255),
                                        height: 1,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // CarouselSlider with animated cards
                        SizedBox(
                          height: 250,
                          child: CarouselUsers.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : CarouselSlider.builder(
                                  itemCount: CarouselUsers.length,
                                  carouselController: _carouselController,
                                  itemBuilder: (context, index, realIndex) {
                                    final newsItem = CarouselUsers[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // Handle card tap
                                        print('Tapped on item $index');
                                      },
                                      child: _buildNewsCard(
                                        imageUrl: newsItem['urlToImage'] ??
                                            'https://via.placeholder.com/150',
                                        title: newsItem['title'] ?? 'No title',
                                        publishedDate:
                                            newsItem['publishedAt'] ??
                                                'No Date',
                                        url: newsItem['url'],
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: 250,
                                    autoPlay:
                                        false, // Disable autoPlay to use manual control
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.8,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentPage = index;
                                      });
                                    },
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Dots Indicator
                        CarouselUsers.isEmpty
                            ? const SizedBox
                                .shrink() // Fallback UI for the indicator
                            : _buildDotsIndicator(),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Container with "Recommended" title and "View All" text
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recommended',
                                style: TextStyle(
                                  fontFamily: 'FormaDJRMicro',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color: Color.fromARGB(205, 219, 225, 227),
                                  height: 1,
                                  letterSpacing: -1,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CardRecommend(),
                                    ),
                                  );
                                },
                                child: Container(
                                  color:
                                      const Color.fromARGB(192, 115, 146, 230),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(236, 255, 255, 255),
                                        height: 1,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: cardHeight * numberOfCards,
                          child: const listCards(value: 'everything'),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  // Future<void> carouselGettr() async {
  //   const String url =
  //       'https://newsapi.org/v2/top-headlines?language=en&sortBy=publishedAt&pageSize=5&apiKey=1ff6b6d53d834ec9b98b1374caed251f';
  //   final uri = Uri.parse(url);
  //   try {
  //     final response = await http.get(uri);
  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body);
  //       setState(() {
  //         CarouselUsers = (json['articles'] as List<dynamic>).where((article) {
  //           return article['urlToImage'] != null;
  //         }).toList();
  //       });
  //
  //       // Start the timer only if there are items
  //       if (CarouselUsers.isNotEmpty) {
  //         _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
  //           int nextPage = (_currentPage + 1) % CarouselUsers.length;
  //           _carouselController.animateToPage(
  //             nextPage,
  //             duration: const Duration(milliseconds: 300),
  //             curve: Curves.easeInOut,
  //           );
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching articles: $e');
  //   }
  // }


  Future<void> carouselGettr() async {
    const String url =
        'https://newsapi.org/v2/everything?q=everything&language=en&sortBy=publishedAt&from=2024-08-01&to=2024-08-25&pageSize=5&apiKey=c5c9dfe1d21245f5bcf1d191d176b537';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          CarouselUsers = (json['articles'] as List<dynamic>).where((article) {
            // Only include articles with all required fields
            return article['urlToImage'] != null &&
                article['title'] != null &&
                article['publishedAt'] != null &&
                article['url'] != null;
          }).toList();
        });

        // Start the timer only if there are items
        if (CarouselUsers.isNotEmpty) {
          _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
            int nextPage = (_currentPage + 1) % CarouselUsers.length;
            _carouselController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        }
      }
    } catch (e) {
      print('Error fetching articles: $e');
    }
  }


  Widget _buildDotsIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _currentPage,
      count: CarouselUsers.length,
      effect: ScaleEffect(
        dotHeight: 8.0,
        dotWidth: 8.0,
        spacing: 8.0,
        scale: 1.2,
        dotColor: Colors.white.withOpacity(0.5),
        activeDotColor: Colors.white,
      ),
    );
  }

  Widget _buildNewsCard({
    required String imageUrl,
    required String title,
    required String publishedDate,
    required String url,
  }) {
    String formattedDate = 'Unknown Date';
    if (publishedDate.isNotEmpty) {
      DateTime dateTime = DateTime.parse(publishedDate);
      formattedDate = DateFormat('MMMM d, y HH:mm').format(dateTime);
    }
    return GestureDetector(
      onTap: () => navigateToWebView(url),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Adjust the radius as needed
        ),
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  color: Colors.black54,
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'FormaDJRMicro',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedDate,
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


