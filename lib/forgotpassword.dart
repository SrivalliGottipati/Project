import 'package:flutter/material.dart';
import 'package:trendview2/Frostedglass.dart';
import 'package:trendview2/secrets.dart';

void showPasswordResetBottomSheet(BuildContext context) {
  final nameController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (BuildContext context) {
      final formKey = GlobalKey<FormState>();
      return FrostedGlassBox(
        theWidth: MediaQuery.of(context).size.width,
        theHeight: MediaQuery.of(context).size.height * 0.7,
        theChild: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontFamily: 'FormaDJRMicro',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(205, 219, 225, 227),
                    height: 1,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: "Name",
                    hintStyle: const TextStyle(
                      fontFamily: 'FormaDJRMicro',
                      fontSize: 15,
                      color: Color.fromARGB(192, 242, 242, 242),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (name) {
                    final userExists =
                        all_users.any((user) => user['name'] == name);
                    return userExists ? null : 'Name not found';
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: newPasswordController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: "New Password",
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
                  validator: (password) {
                    return password != null && password.length < 5
                        ? 'Password must be at least 5 characters long'
                        : null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: "Confirm New Password",
                    hintStyle: const TextStyle(
                      fontFamily: 'FormaDJRMicro',
                      fontSize: 15,
                      color: Color.fromARGB(192, 235, 235, 235),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (confirmPassword) {
                    return confirmPassword != newPasswordController.text
                        ? 'Passwords do not match'
                        : null;
                  },
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(192, 115, 146, 230)),
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Handle password reset logic here

                        // Perform password reset operation

                        Navigator.of(context).pop(); // Close the bottom sheet
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
