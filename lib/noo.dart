// Widget cardCreate(
//     BuildContext context, {
//     required String title,
//     required String description,
//     required String author,
//     required String img_url,
//     required String time,
//     required String url,
//     required Set<String> likedsett,
//     required Set<String> followedsett,
//     String? value,
//   }) {
//     String formattedTime = 'Null';
//     if (time != 'Null') {
//       DateTime dateTime = DateTime.parse(time);
//       formattedTime = DateFormat('MMMM d, y').format(dateTime);
//     }
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: GlassmorphicContainer(
//         height: MediaQuery.of(context).size.height * 0.5,
//         width: double.infinity,
//         borderRadius: 20,
//         border: 3,
//         blur: 10,
//         linearGradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFffffff).withOpacity(0.1),
//               Color(0xFFFFFFFF).withOpacity(0.1),
//             ],
//             stops: [
//               0.1,
//               1,
//             ]),
//         borderGradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color.fromARGB(120, 0, 0, 0).withOpacity(0.5),
//             Color.fromARGB(120, 0, 0, 0).withOpacity(0.5),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start, // Ensure text starts from the left
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                         color: Color.fromARGB(120, 0, 0, 0), width: 3),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(25),
//                     ),
//                     child: Image.network(
//                       img_url,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 title,
//                 textAlign: TextAlign.left,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 bottom: 10,
//                 top: 5,
//               ),
//               child: Text(
//                 description,
//                 maxLines: 4,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: Colors.white,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 18.0,
//                   left: 18,
//                   right: 18,
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Color.fromARGB(64, 255, 255, 255),
//                     border: Border.all(
//                         color: Color.fromARGB(120, 0, 0, 0), width: 3),
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(top: 8, bottom: 4, left: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               author,
//                               style: TextStyle(
//                                   color: const Color.fromARGB(255, 35, 35, 35),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20),
//                             ),
//                             Text(
//                               formattedTime,
//                               style: TextStyle(
//                                   color: const Color.fromARGB(255, 35, 35, 35),
//                                   fontSize: 10),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Spacer(),
//                       IconButton(
//                         padding: EdgeInsets.zero,
//                         constraints: BoxConstraints(),
//                         visualDensity:
//                             VisualDensity(horizontal: -4, vertical: -4),
//                         icon: followedsett.contains(url)
//                             ? Icon(Icons.add_circle)
//                             : Icon(Icons.add_circle_outline),
//                         color: Colors.black,
//                         onPressed: () {
//                           setState(() {
//                             followedsett.contains(url)
//                                 ? followedsett.remove(url)
//                                 : followedsett.add(url);
//                             print('followed set = $followedsett');
//                           });
//                         },
//                       ),
//                       IconButton(
//                           icon: likedsett.contains(url)
//                               ? Icon(Icons.bookmark)
//                               : Icon(Icons.bookmark_border),
//                           color: Colors.black,
//                           onPressed: () {
//                             setState(() {
//                               likedsett.contains(url)
//                                   ? likedsett.remove(url)
//                                   : likedsett.add(url);
//                               print("likedset = $likedsett");
//                             });
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//       ),
//     );
//   }