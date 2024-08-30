// // import 'package:flutter/material.dart';
// // import 'package:flutter_swiper_plus/flutter_swiper_plus.dart'; // Import Swiper Plus package
// // import 'categorycard1.dart'; // Ensure this import is correct for accessing your existing card widget
// //
// // class ViewAllPage extends StatelessWidget {
// //   const ViewAllPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('View All'),
// //       ),
// //       body: ListView(
// //         children: [
// //           _buildCategorySection('General'),
// //           _buildCategorySection('Business'),
// //           _buildCategorySection('Entertainment'),
// //           _buildCategorySection('Health'),
// //           _buildCategorySection('Science'),
// //           _buildCategorySection('Sports'),
// //           _buildCategorySection('Technology'),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildCategorySection(String category) {
// //     // Fetch data based on the category
// //     List<dynamic> users = _fetchDataForCategory(category);
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Text(
// //             category,
// //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         Container(
// //           height: 300, // Adjust height as needed
// //           padding: EdgeInsets.symmetric(horizontal: 16.0),
// //           child: Swiper(
// //             itemBuilder: (context, index) {
// //               final user = users[index];
// //               return InkWell(
// //                 onTap: () {
// //                   print('Tapped');
// //                 },
// //                 child: ProfileCard(
// //                   title: user['title'] ?? 'No Title',
// //                   description: user['description'] ?? 'No Description',
// //                   author: user['source']['name'] ?? 'No Author',
// //                   time: user['publishedAt'] ?? 'Null',
// //                 ),
// //               );
// //             },
// //             itemCount: users.length,
// //             itemWidth: 300,
// //             itemHeight: 300,
// //             loop: true,
// //             autoplay: true,
// //             duration: 1200,
// //             scrollDirection: Axis.horizontal,
// //             layout: SwiperLayout.STACK,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // Replace this method with actual data fetching logic
// //   List<dynamic> _fetchDataForCategory(String category) {
// //     // Example static data
// //     return List.generate(5, (index) {
// //       return {
// //         'title': '$category Title $index',
// //         'description': '$category Description $index',
// //         'source': {'name': '$category Author $index'},
// //         'publishedAt': '2024-07-28',
// //       };
// //     });
// //   }
// // }
// //
// //
// //
// // class ProfileCard extends StatelessWidget {
// //   final String title;
// //   final String description;
// //   final String author;
// //   final String time;
// //
// //   const ProfileCard({
// //     Key? key,
// //     required this.title,
// //     required this.description,
// //     required this.author,
// //     required this.time,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: EdgeInsets.all(8.0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Image Placeholder
// //           Container(
// //             height: 150.0,
// //             decoration: BoxDecoration(
// //               color: Colors.grey[200],
// //               image: DecorationImage(
// //                 image: AssetImage('assets/bg.png'), // Replace with your image asset path
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Text(
// //               title,
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //             child: Text(
// //               description,
// //               style: TextStyle(fontSize: 14),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
// //             child: Text(
// //               'By $author | $time',
// //               style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_swiper_plus/flutter_swiper_plus.dart'; // Import Swiper Plus package
// // // import 'package:http/http.dart' as http; // Import http package
// // // import 'categorycard1.dart'; // Ensure this import is correct for accessing your existing card widget
// // //
// // // class ViewAllPage extends StatefulWidget {
// // //   final String url;
// // //
// // //   const ViewAllPage({super.key, required this.url});
// // //
// // //   @override
// // //   _ViewAllPageState createState() => _ViewAllPageState();
// // // }
// // //
// // // class _ViewAllPageState extends State<ViewAllPage> {
// // //   late Future<List<dynamic>> _newsData;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _newsData = fetchApiData();
// // //   }
// // //
// // //   Future<List<dynamic>> fetchApiData() async {
// // //     try {
// // //       final response = await http.get(Uri.parse(widget.url));
// // //       print('Response status: ${response.statusCode}');
// // //       print('Response body: ${response.body}');
// // //
// // //       if (response.statusCode == 200) {
// // //         final data = json.decode(response.body);
// // //         print('Decoded data: $data'); // Check if data structure is correct
// // //         final articles = data['articles'] ?? [];
// // //         return articles
// // //             .where((item) =>
// // //         item['urlToImage'] != null && item['urlToImage'].isNotEmpty)
// // //             .toList();
// // //       } else {
// // //         throw Exception('Failed to load API content');
// // //       }
// // //     } catch (e) {
// // //       print('Error: $e');
// // //       return []; // Return an empty list on error
// // //     }
// // //   }
// // //
// // //   @override
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('View All'),
// // //       ),
// // //       body: FutureBuilder<List<dynamic>>(
// // //         future: _newsData,
// // //         builder: (context, snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return Center(child: CircularProgressIndicator());
// // //           } else if (snapshot.hasError) {
// // //             return Center(child: Text('Error: ${snapshot.error}'));
// // //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //             return Center(child: Text('No data available'));
// // //           }
// // //
// // //           final articles = snapshot.data!;
// // //
// // //           return ListView(
// // //             children: [
// // //               _buildCategorySection('General', articles),
// // //               _buildCategorySection('Business', articles),
// // //               _buildCategorySection('Entertainment', articles),
// // //               _buildCategorySection('Health', articles),
// // //               _buildCategorySection('Science', articles),
// // //               _buildCategorySection('Sports', articles),
// // //               _buildCategorySection('Technology', articles),
// // //             ],
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //
// // //   Widget _buildCategorySection(String category, List<dynamic> articles) {
// // //     // Adjust the filtering based on actual category matching logic
// // //     final categoryArticles = articles.where((article) {
// // //       // Check if article category matches (you may need to adjust this based on your API response)
// // //       // Example: checking if source name or title contains the category name
// // //       return article['source']['name'].toLowerCase().contains(category.toLowerCase());
// // //     }).toList();
// // //
// // //     if (categoryArticles.isEmpty) {
// // //       return SizedBox.shrink();
// // //     }
// // //
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Text(
// // //             category,
// // //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// // //           ),
// // //         ),
// // //         Container(
// // //           height: 300,
// // //           padding: EdgeInsets.symmetric(horizontal: 16.0),
// // //           child: Swiper(
// // //             itemBuilder: (context, index) {
// // //               final article = categoryArticles[index];
// // //               return InkWell(
// // //                 onTap: () {
// // //                   print('Tapped');
// // //                 },
// // //                 child: buildSmallCardNew(
// // //                   title: article['title'] ?? 'No Title',
// // //                   description: article['description'] ?? 'No Description',
// // //                   author: article['author'] ?? 'No Author',
// // //                   time: article['publishedAt'] ?? 'Null',
// // //                   imageUrl: article['urlToImage'] ?? 'assets/bg.png',
// // //                 ),
// // //               );
// // //             },
// // //             itemCount: categoryArticles.length,
// // //             itemWidth: 300,
// // //             itemHeight: 300,
// // //             loop: true,
// // //             autoplay: true,
// // //             duration: 1200,
// // //             scrollDirection: Axis.horizontal,
// // //             layout: SwiperLayout.STACK,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //
// // //   Widget buildSmallCardNew({
// // //     required String title,
// // //     required String description,
// // //     required String author,
// // //     required String time,
// // //     required String imageUrl,
// // //   }) {
// // //     return Card(
// // //       margin: EdgeInsets.all(8.0),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Container(
// // //             height: 100.0,
// // //             decoration: BoxDecoration(
// // //               color: Colors.grey[200],
// // //               image: imageUrl.isNotEmpty
// // //                   ? DecorationImage(
// // //                 image: NetworkImage(imageUrl),
// // //                 fit: BoxFit.cover,
// // //               )
// // //                   : null,
// // //             ),
// // //             child: imageUrl.isEmpty
// // //                 ? Center(child: Icon(Icons.image, color: Colors.grey[500]))
// // //                 : null,
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(8.0),
// // //             child: Text(
// // //               title,
// // //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
// // //             child: Text(
// // //               description,
// // //               style: TextStyle(fontSize: 14),
// // //               maxLines: 2,
// // //               overflow: TextOverflow.ellipsis,
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
// // //             child: Text(
// // //               'By $author | $time',
// // //               style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// //
// //
// //
// //
//
// import 'package:flutter/material.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'dart:ui';
//
// class ApiCardScreen extends StatefulWidget {
//   final String url;
//
//   ApiCardScreen({required this.url});
//
//   @override
//   _ApiCardScreenState createState() => _ApiCardScreenState();
// }
//
// class _ApiCardScreenState extends State<ApiCardScreen> {
//   List<dynamic> apiContent = [];
//   Set<int> bookmarkSet = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchApiData();
//   }
//
//   Future<void> fetchApiData() async {
//     try {
//       final response = await http.get(Uri.parse(widget.url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body)['articles'];
//         setState(() {
//           apiContent = data
//               .where((item) =>
//           item['urlToImage'] != null && item['urlToImage'].isNotEmpty)
//               .toList();
//         });
//       } else {
//         throw Exception('Failed to load API content');
//       }
//     } catch (e) {
//       print('Error: $e');
//       // Optionally, show a user-friendly error message here
//     }
//   }
//
//   void navigateToWebView(String url) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => WebViewScreen(url: url),
//       ),
//     );
//   }
//
//   Widget buildSmallCardNew(BuildContext context, dynamic content, int index) {
//     return GestureDetector(
//       onTap: () => navigateToWebView(content['url'] ?? ''),
//       child: Container(
//         margin: EdgeInsets.all(10),
//         width: 150,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15.0), // Adjust as needed
//           child: BackdropFilter(
//             filter: ImageFilter.blur(
//                 sigmaX: 10.0, sigmaY: 10.0), // Adjust blur effect as needed
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2), // Semi-transparent color
//                 borderRadius: BorderRadius.circular(15.0),
//                 border: Border.all(
//                   color: Colors.white
//                       .withOpacity(0.3), // Border color for better glass effect
//                   width: 1.5,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(15),
//                       topRight: Radius.circular(15),
//                     ),
//                     child: Image.network(
//                       content['urlToImage'] ?? '',
//                       fit: BoxFit.cover,
//                       width: 150,
//                       height: 145, // Adjusted image height to prevent overflow
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       limitWords(
//                           content['title'] ?? '', 3), // Limit title to 3 words
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           color: Colors.white),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       limitWords(content['description'] ?? '',
//                           4), // Limit description to 4 words
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8.0, right: 8.0, bottom: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.add_circle_outline,
//                               color: Colors.white),
//                           onPressed: () {},
//                         ),
//                         IconButton(
//                           icon: bookmarkSet.contains(index)
//                               ? Icon(Icons.bookmark, color: Colors.white)
//                               : Icon(Icons.bookmark_border,
//                               color: Colors.white),
//                           onPressed: () {
//                             setState(() {
//                               bookmarkSet.contains(index)
//                                   ? bookmarkSet.remove(index)
//                                   : bookmarkSet.add(index);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String limitWords(String text, int wordLimit) {
//     List<String> words = text.split(' ');
//     if (words.length <= wordLimit) {
//       return text;
//     } else {
//       return words.take(wordLimit).join(' ') + '...';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter the API content to include only items with a valid urlToImage
//     List validApiContent = apiContent
//         .where((item) =>
//     item['urlToImage'] != null &&
//         item['title'] != null &&
//         item['description'] != null &&
//         item['author'] != null &&
//         item['url'] != null &&
//         item['publishedAt'] != null)
//         .toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('API Cards'),
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/bg.jpg', // Replace with your image URL
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Ensure the background covers the entire screen height
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 height: double.infinity,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // Display small cards in a horizontal list
//                       if (validApiContent.isNotEmpty)
//                         Container(
//                           height: 302, // Adjusted height to ensure no overflow
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: validApiContent.length > 5
//                                 ? 5
//                                 : validApiContent.length,
//                             itemBuilder: (context, index) {
//                               var item = validApiContent[index];
//                               return buildSmallCardNew(
//                                   context, item, index);
//                             },
//                           ),
//                         ),
//
//                       // Display the remaining small cards in a vertical list if present
//                       if (validApiContent.length > 5)
//                         Column(
//                           children: validApiContent
//                               .skip(5)
//                               .map((item) => buildSmallCardNew(
//                               context, item, validApiContent.indexOf(item)))
//                               .toList(),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class WebViewScreen extends StatelessWidget {
//   final String url;
//
//   const WebViewScreen({required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Web View'),
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
//         initialSettings: InAppWebViewSettings(
//           useShouldOverrideUrlLoading: true,
//           mediaPlaybackRequiresUserGesture: false,
//         ),
//         onWebViewCreated: (InAppWebViewController controller) {},
//         onLoadStart: (InAppWebViewController controller, Uri? url) {},
//         onLoadStop: (InAppWebViewController controller, Uri? url) async {},
//         onReceivedError: (InAppWebViewController controller,
//             WebResourceRequest request, WebResourceError error) {
//           // Handle the error
//           print('Error: ${error.description}');
//         },
//         shouldOverrideUrlLoading: (controller, navigationAction) async {
//           return NavigationActionPolicy.ALLOW;
//         },
//       ),
//     );
//   }
// }
//
//


import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Viewall extends StatefulWidget {
  final List<String> categories; // List of categories

  Viewall({required this.categories});

  @override
  _ViewallState createState() => _ViewallState();
}

class _ViewallState extends State<Viewall> {
  Map<String, List<dynamic>> apiContents = {};


  @override
  void initState() {
    super.initState();
    fetchApiData(); // Fetch data when the widget is initialized
  }

  // Function to fetch data for each category
  Future<void> fetchApiData() async {
    for (String category in widget.categories) {
      String url = buildUrl(category);
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = json.decode(response.body)['articles'];
          setState(() {
            apiContents[category] = data
                .where((item) => item['urlToImage'] != null && item['urlToImage'].isNotEmpty)
                .toList();
          });
        } else {
          throw Exception('Failed to load API content');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  // Function to build the URL for the API call
  String buildUrl(String category) {
    String apiKey = '51a0cfa0f4d241058acee64366ff25b1';
    return 'https://newsapi.org/v2/everything?q=$category&language=en&apiKey=$apiKey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories'), // App bar title
      ),
      body: widget.categories.isEmpty
          ? Center(child: Text('No Categories Available')) // Show message if no categories are available
          : PageView.builder(
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          String category = widget.categories[index];
          List<dynamic>? articles = apiContents[category];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading for each category
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  // color: Colors.blueAccent,
                  child: Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Display articles for each category
              Expanded(
                child: articles == null
                    ? Center(child: CircularProgressIndicator()) // Show loader while articles are loading
                    : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, articleIndex) {
                    final article = articles[articleIndex];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(url: article['url']),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(article['urlToImage']),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                article['title'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                article['description'] ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
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
