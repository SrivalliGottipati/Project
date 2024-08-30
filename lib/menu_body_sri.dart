//
//
// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// import 'card_creation_sri.dart'; // Ensure this import is correct for your project
//
// List<Map<String, dynamic>> listItems = [
//   {'title': 'Business'},
//   {'title': 'Entertainment'},
//   {'title': 'General'},
//   {'title': 'Health'},
//   {'title': 'Science'},
//   {'title': 'Sports'},
//   {'title': 'Technology'},
// ];
//
// String buildUrl(String title) {
//   String apiKey = 'c085ed7b20f54213805729c89cda6887';
//   return 'https://newsapi.org/v2/everything?q=${Uri.encodeComponent(title)}&pageSize=14&apiKey=$apiKey';
// }
//
// List<Widget> buildListItems(BuildContext context, List<Map<String, dynamic>> listItems) {
//   return listItems.map<Widget>((item) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
//
//       child: ListTile(
//         title: Container(
//           decoration: BoxDecoration(
//             color: Color(0xFF5A5859),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//           child: Text(
//             item['title'],
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         onTap: () {
//           String url = buildUrl(item['title']);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ApiCardScreen(url: url),
//             ),
//           );
//         },
//       ),
//     );
//   }).toList();
// }
//
//
//

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http; // Add the http package for network requests
//
// import 'card_creation_sri.dart'; // Ensure this import is correct for your project
//
// List<Map<String, dynamic>> listItems = [
//   {'title': 'Business', 'id': 'business'},
//   {'title': 'Entertainment', 'id': 'entertainment'},
//   {'title': 'General', 'id': 'general'},
//   {'title': 'Health', 'id': 'health'},
//   {'title': 'Science', 'id': 'science'},
//   {'title': 'Sports', 'id': 'sports'},
//   {'title': 'Technology', 'id': 'technology'},
// ];
//
// String buildUrl(String id) {
//   String apiKey = '51a0cfa0f4d241058acee64366ff25b1';
//   return 'https://newsapi.org/v2/top-headlines?category=$id&language=en&apiKey=$apiKey';
// }
//
// List<Widget> buildListItems(BuildContext context, List<Map<String, dynamic>> listItems) {
//   return listItems.map<Widget>((item) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
//       child: ListTile(
//         title: Container(
//           decoration: BoxDecoration(
//             color: Color(0xFF5A5859),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//           child: Text(
//             item['title'],
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         onTap: () async {
//           String url = buildUrl(item['id']);
//           // Fetch data to ensure URL is working
//           try {
//             final response = await http.get(Uri.parse(url));
//             if (response.statusCode == 200) {
//               // Proceed if API request is successful
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ApiCardScreen(url: url),
//                 ),
//               );
//             } else {
//               // Handle API errors
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Failed to load data')),
//               );
//             }
//           } catch (e) {
//             // Handle network errors
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error: $e')),
//             );
//           }
//         },
//       ),
//     );
//   }).toList();
// }

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart' as http;
import 'card_creation_sri.dart';

List<Map<String, dynamic>> listItems = [
  {'title': 'Business', 'id': 'business'},
  {'title': 'Entertainment', 'id': 'entertainment'},
  {'title': 'General', 'id': 'general'},
  {'title': 'Health', 'id': 'health'},
  {'title': 'Science', 'id': 'science'},
  {'title': 'Sports', 'id': 'sports'},
  {'title': 'Technology', 'id': 'technology'},
];

String buildUrl(String id) {
  String apiKey = '51a0cfa0f4d241058acee64366ff25b1';
  return 'https://newsapi.org/v2/top-headlines?category=$id&language=en&apiKey=$apiKey';
}

List<Widget> buildListItems(
    BuildContext context, List<Map<String, dynamic>> listItems) {
  return listItems.map<Widget>((item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: ListTile(
        title: GlassmorphicContainer(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          width: double.infinity,
          height: 60,
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
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft, // Align text to the left
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                item['title'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        onTap: () async {
          String url = buildUrl(item['id']);
          try {
            final response = await http.get(Uri.parse(url));
            if (response.statusCode == 200) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApiCardScreen(url: url),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to load data')),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
          }
        },
      ),
    );
  }).toList();
}
