// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class UsersPage extends StatefulWidget {
//   const UsersPage({super.key});
//
//   @override
//   State<UsersPage> createState() => _UsersPageState();
// }
//
// class _UsersPageState extends State<UsersPage> {
//   List<dynamic> users = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }
//
//   Future<void> fetchUsers() async {
//     final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
//     if (response.statusCode == 200) {
//       setState(() {
//         users = jsonDecode(response.body)['data'];
//       });
//     } else {
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Users List'),
//       ),
//       body: users.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(user['avatar']),
//             ),
//             title: Text('${user['first_name']} ${user['last_name']}'),
//             subtitle: Text(user['email']),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
//

import 'package:flutter/material.dart';

import 'User_api_Controllers.dart';

class userspage extends StatefulWidget {
  final int page;

  const userspage({super.key, required this.page});

  @override
  State<userspage> createState() => _userspageState();
}

class _userspageState extends State<userspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future:UserApiController().getUserByPage(widget.page), builder:(context,snap){
        if(snap.hasData){
          return ListView.builder(
              itemCount: snap.data!["data"].length,
              itemBuilder:(context,index){
                final user = snap.data!["data"][index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        user["avatar"] ?? [""]
                    ),
                  ),
                  title: Text("${user["first_name"] ?? ""} ${user["last_name"] ?? " "}"),
                  subtitle: Text("${user["email"]?? " "}"),
                );
              });
        }
        else if(snap.hasError){
          return Text("Error while fetching user details");
        }
        return CircularProgressIndicator();
      }
      ),
    );
  }
}

class TabUserApi extends StatefulWidget {
  const TabUserApi({super.key});

  @override
  State<TabUserApi> createState() => _TabUserApiState();
}

class _TabUserApiState extends State<TabUserApi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          bottom: TabBar(
            tabs:[
              Tab(text: 'Page1',),
              Tab(text: 'Page2',)
            ]
          ),
        ),
        body: TabBarView(
          children: [
            userspage(page: 1),
            userspage(page: 2),
          ],
        ),

      ),
    );
  }
}
