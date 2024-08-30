import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<dynamic> CarouselUsers = [];

class Testt extends StatefulWidget {
  const Testt({super.key});

  @override
  State<Testt> createState() => _TesttState();
}

class _TesttState extends State<Testt> {
  final CarouselController _carouselController = CarouselController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    carouselGettr();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
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
                            publishedDate: newsItem['publishedAt'] ?? 'No Date',
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
                ? const SizedBox.shrink() // Fallback UI for the indicator
                : _buildDotsIndicator(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> carouselGettr() async {
    const String url =
        'https://newsapi.org/v2/top-headlines?language=en&from=2024-07-27&to=2024-07-29&sortBy=publishedAt&apiKey=1ff6b6d53d834ec9b98b1374caed251f';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          CarouselUsers = (json['articles'] as List<dynamic>).where((article) {
            final sourceId = article['source']['id'];
            final sourceName = article['source']['name'];
            return article['urlToImage'] != null;
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
  }) {
    String formattedDate = 'Unknown Date';
    if (publishedDate.isNotEmpty) {
      DateTime dateTime = DateTime.parse(publishedDate);
      formattedDate = DateFormat('MMMM d, y HH:mm').format(dateTime);
    }
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
