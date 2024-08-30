import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final userCtrl = TextEditingController();
  Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 50,
            ),
            Image(image: NetworkImage("https://tse4.mm.bing.net/th?id=OIP.8SVgggxQcO5L6Dw_61ac4QHaEK&pid=Api&P=0&h=180")),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: userCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter user ID",
                  labelText: "Enter user ID",
                  focusColor: Colors.black
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                if (userCtrl.text.isNotEmpty) {
                  Map<String, dynamic> data = await getUserDetails(userCtrl.text.trim());
                  if (data.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(userData: data),
                      ),
                    );
                  }
                }
              },
              child: Container(
                height: 55,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black
                ),
                child: Center(child: Text("Details",style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    try {
      Uri url = Uri.parse("https://api.github.com/users/$userId");
      final res = await http.get(url);
      print(res.body);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      }
      return {};
    } catch (err) {
      return {};
    }
  }
}

class UserDetailsPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserDetailsPage({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${userData["login"]}'s Details"),
      ),
      body: Center(
          child: Visibility(
            visible: userData.isNotEmpty,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image(image: NetworkImage("${userData["avatar_url"] ?? ""}"),
                          height: 100,
                          width: 100,),
                        Text("${userData["login"] ?? "User NotFound"}"),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                // Text(),
                                Text("${userData["followers"] ?? "User NotFound"}"),
                                Text("Followers")
                              ],
                            ),
                            SizedBox(width: 70,),
                            Column(
                              children: [
                                // Text(),
                                Text("${userData["following"] ?? "User NotFound"}"),
                                Text("Following")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Text("Repositories-${userData["public_repos"]??0}"),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
      ),
    );
  }
}

