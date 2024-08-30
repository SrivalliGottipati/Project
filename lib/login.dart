import 'package:flutter/material.dart';
import 'package:trendview2/bottombar.dart';
import 'package:trendview2/forgotpassword.dart';
import 'package:trendview2/register.dart';
import 'package:trendview2/secrets.dart';

// final _formkeyy  = GlobalKey<FormState>();
class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GlobalKey<FormState> _formkeyy = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login1.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome\n Back.',
                style: TextStyle(
                  fontFamily: 'FormaDJRMicro',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Color.fromARGB(205, 219, 225, 227),
                  height: 1,
                  letterSpacing: -1,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formkeyy,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: loginEmailController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Username...",
                                hintStyle: const TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 15,
                                  color: Color.fromARGB(192, 76, 80, 91),
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                try {
                                  all_users.firstWhere(
                                      (user) => user['name'] == value);
                                } catch (e) {
                                  return 'User not found';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: loginPasswordController,
                              style: const TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password...",
                                  hintStyle: const TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 15,
                                    color: Color.fromARGB(192, 76, 80, 91),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                try {
                                  all_users.firstWhere((user) =>
                                      user['name'] ==
                                          loginEmailController.text &&
                                      user['password'] == value);
                                } catch (e) {
                                  return 'Incorrect password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontFamily: 'FormaDJRMicro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                    color: Color.fromARGB(205, 12, 12, 12),
                                    height: 1,
                                    letterSpacing: -1,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        if (_formkeyy.currentState!
                                            .validate()) {
                                          bool? userVerified = validateUser(
                                              loginEmailController.text,
                                              loginPasswordController.text);
                                          if (userVerified == true) {
                                            final_user =
                                                loginEmailController.text;
                                            final_pass =
                                                loginPasswordController.text;
                                          }

                                          //final_email =
                                          loginVerifyDialog(
                                              userVerified, context);
                                          print('${final_pass} ${final_user}');
                                        } else {
                                          // Handle login failure
                                          loginVerifyDialog(false, context);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  color:
                                      const Color.fromARGB(192, 115, 146, 230),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MyRegister(),
                                        ),
                                      );
                                    },
                                    style: const ButtonStyle(),
                                    child: const Text(
                                      'Sign Up',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'FormaDJRMicro',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Color.fromARGB(205, 12, 12, 12),
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      showPasswordResetBottomSheet(context);
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 15,
                                        color: Color.fromARGB(192, 76, 80, 91),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: handleSkip,
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontFamily: 'FormaDJRMicro',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: Color.fromARGB(192, 115, 146, 230),
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Add this method to handle the skip functionality
  void handleSkip() {
    setState(() {
      didSkip = true;
      final_user = 'Guest';
      final_email = '';
      final_pass = '';
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomBar(),
      ),
    );
  }

  void loginVerifyDialog(bool? userVerified, BuildContext context) {
    if (userVerified == true) {
      // Reset didSkip when login is successful
      didSkip = false;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomBar(),
                  ),
                );
              },
              child: const Text('Close'),
            ),
          ],
          title: const Text('Verification Successful'),
          contentPadding: const EdgeInsets.all(10),
          content: const Text('User is Verified'),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
          title: const Text('Verification NOT SUCCESFULL'),
          contentPadding: const EdgeInsets.all(10),
          content: const Text('User is NOT Verified'),
        ),
      );
    }
  }
}
