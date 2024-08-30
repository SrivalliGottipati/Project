import 'package:flutter/material.dart';

class Account1 extends StatelessWidget {
  const Account1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(204, 214, 213, 213),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 151, 148, 148),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2.0),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,

                // child: IconButton(
                //   icon: Icon(Icons.person_sharp, color: Colors.black),
                //   onPressed: (){},
                // ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF5A5859),
            ),
            child: const Row(
              children: [
                Text(
                  '  Name   :   ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                Text('Masroor',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF5A5859)),
            child: const Row(
              children: [
                Text('  Email   :  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    )),
                Text('Masroor@2004',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF5A5859)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: ExpansionTile(
                trailing: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.white,
                ),
                title: Text('MoreDetails',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    )),
                children: [
                  ListTile(
                    leading: Column(
                      children: [
                        Text('Username',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Password',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            )),
                      ],
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
