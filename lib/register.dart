import 'package:flutter/material.dart';
import 'package:trendview2/login.dart';
import 'package:trendview2/secrets.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register1.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                'Create\nAccount.',
                style: TextStyle(
                  fontFamily: 'FormaDJRMicro',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Color.fromARGB(205, 219, 225, 227),
                  height: 1,
                  letterSpacing: 1,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Enter Username",
                                  hintStyle: const TextStyle(
                                    fontFamily: 'FormaDJRMicro',
                                    fontSize: 15,
                                    color: Color.fromARGB(192, 246, 246, 246),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (name) => name!.length < 3
                                  ? "Name must be at least 3 Characters"
                                  : null,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Enter Your Email",
                                hintStyle: const TextStyle(
                                  fontFamily: 'FormaDJRMicro',
                                  fontSize: 15,
                                  color: Color.fromARGB(192, 246, 246, 246),
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (name) =>
                                  name!.contains('@') && name.contains('.com')
                                      ? null
                                      : 'Enter correct email',
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Enter Password",
                                  hintStyle: const TextStyle(
                                    fontFamily: 'FormaDJRMicro',
                                    fontSize: 15,
                                    color: Color.fromARGB(192, 246, 246, 246),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (name) => name!.length < 5
                                  ? "Password must be at least 5 Characters"
                                  : null,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sign Up!',
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
                                      setState(() {
                                        if (_formkey.currentState!.validate()) {
                                          addUser(
                                              nameController.text,
                                              passwordController.text,
                                              emailController.text);
                                          print(
                                              '${nameController.text} ${passwordController.text} ${emailController.text}');
                                          print('Submit Button Pressed');

                                          registerVerifyDialog(context);
                                        }
                                      });
                                      print(all_users);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyLogin(),
                                      ),
                                    );
                                  },
                                  style: const ButtonStyle(),
                                  child: Container(
                                    color: const Color.fromARGB(
                                        192, 115, 146, 230),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Sign In',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'FormaDJRMicro',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color:
                                              Color.fromARGB(205, 12, 12, 12),
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
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

  void registerVerifyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
        title: const Text('Registration Successful'),
        contentPadding: const EdgeInsets.all(10),
        content: const Text('User is Registered'),
      ),
    );
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
