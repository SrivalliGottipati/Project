import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: WavePainter(),
            ),
            Positioned(
              top: 140, // Position the profile picture container
              left: MediaQuery.of(context).size.width /
                  1.9, // Center horizontally
              child: Container(
                width: 150, // Diameter of the circle
                height: 150, // Diameter of the circle
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Colors.white, // Background color of the profile picture
                  border: Border.all(
                    color: Colors.green, // Bright green border color
                    width: 4.0, // Border width
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.3),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(0, 3), // Shadow position
                  //   ),
                  // ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Default person icon when no image is provided
                    Icon(
                      Icons.person,
                      size: 100, // Icon size
                      color: Colors.grey.shade400, // Icon color
                    ),
                    // Uncomment the following code to use an image instead of the icon
                    // if you want to switch between the icon and image
                    // Positioned.fill(
                    //   child: ClipOval(
                    //     child: Image.asset(
                    //       'assets/profile_picture.png', // Path to profile picture
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 350, // Position of the first text field
              left: 16,
              right: 16,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                      icon: Icons.person,
                      label: 'Name',
                      hintText: 'Enter your name',
                    ),
                    const SizedBox(height: 16.0), // Spacing between text fields
                    _buildTextField(
                      icon: Icons.email,
                      label: 'Email',
                      hintText: 'Enter your email',
                    ),
                    const SizedBox(height: 16.0), // Spacing between text fields
                    _buildTextField(
                      icon: Icons.phone,
                      label: 'Phone',
                      hintText: 'Enter your phone number',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 17.0), // Space below each text field
      child: TextField(
        maxLines: maxLines,
        style: const TextStyle(fontSize: 18.0), // Increased font size
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          labelText: label,
          labelStyle:
              const TextStyle(fontSize: 22.0), // Increased label font size
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
                color: Colors.green, width: 2.0), // Highlight border on focus
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 16.0), // Increased padding
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const gradient = LinearGradient(
      colors: [Colors.lightGreen, Colors.green],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0); // Start point at the top
    path.lineTo(size.width, 0); // Extend to the top right corner
    path.lineTo(size.width, size.height * 0.3); // Start the wave
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.3,
    ); // First control point and end point
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      0,
      size.height * 0.3,
    ); // Second control point and end point
    path.close(); // Close the path to the top left corner

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
