import 'package:flutter/material.dart';
import 'package:trendview2/followed.dart';
import 'package:trendview2/saved.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF303030),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Stack(
            children: [
              // Image.asset(
              //   'assets/blurr_greenlight.jpeg',
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: double.infinity,
              // ),
              Column(
                children: [
                  SizedBox(height: 20), // Add padding at the top if needed
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor:
                              Color.fromARGB(255, 200, 199, 199),
                          indicatorWeight: 3,
                          tabs: [
                            Tab(text: "Followed"),
                            Tab(text: "Saved"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Followed(),
                        Saved(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class noFollowing extends StatelessWidget {
  const noFollowing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Following no items',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                'Please use the link below to select from popular topics, articles and writers.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: .8,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red, // Text color
            minimumSize: const Size(150, 50), // Minimum size
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Choose topics to follow',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

Widget followCard(BuildContext context) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF5A5859),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Ensure text starts from the left
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "title",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
                top: 5,
              ),
              child: Text(
                "description",
                style: TextStyle(
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "author",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "time",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
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
                        icon: const Icon(Icons.bookmark_border),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ),
  ]);
}
