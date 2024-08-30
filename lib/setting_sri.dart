import 'package:flutter/material.dart';
import 'package:trendview2/account_sri.dart';
import 'package:flutter/cupertino.dart';

Widget settingsContent(BuildContext context) {
  return Container(
    color: const Color(0xFF1E1E1E), // Dark background for the entire modal
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAppBar(context),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildListTile(
                  icon: CupertinoIcons.person_fill, title: 'Account'),
              const SizedBox(height: 10),
              _buildListTile(
                  icon: CupertinoIcons.bell_fill, title: 'Notifications'),
              const SizedBox(height: 10),
              _buildListTile(
                  icon: CupertinoIcons.eye_fill, title: 'Appearance'),
              const SizedBox(height: 10),
              _buildListTile(
                  icon: CupertinoIcons.lock_fill, title: 'Privacy & Security'),
              const SizedBox(height: 10),
              _buildListTile(
                  icon: CupertinoIcons.question_circle_fill,
                  title: 'Help and Support'),
              const SizedBox(height: 10),
              _buildListTile(
                  icon: CupertinoIcons.info_circle_fill, title: 'About'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAppBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'FormaDJRMicro',
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromARGB(205, 219, 225, 227),
            height: 1,
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white70),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildListTile({
  required IconData icon,
  required String title,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF303030),
      borderRadius: BorderRadius.circular(20),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: CircleAvatar(
        backgroundColor: Colors.white12,
        child: Icon(icon, size: 24, color: Colors.white70),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontWeight: FontWeight.w300,
          fontSize: 20,
          color: Color.fromARGB(236, 255, 255, 255),
          height: 1,
          letterSpacing: 2,
        ),
      ),
      trailing:
          const Icon(CupertinoIcons.chevron_forward, color: Colors.white70),
      onTap: () {
        // Handle tile tap
      },
    ),
  );
}

Widget personContent(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          tileColor: const Color(0xFF484848),
          contentPadding: const EdgeInsets.only(left: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: const Text(
            'Manage Account',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Account()),
              );
            },
          ),
        ),

        // Center(
        //   child: Container(
        //     height: 100,
        //     width: double.infinity,
        //     child: Row(
        //       children: [
        //         Text('Manage Account',style: TextStyle(color: Colors.white),),
        //         IconButton(onPressed: (
        //             ){
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => Account()),
        //           );
        //         }, icon: Icon(Icons.arrow_forward_ios))
        //       ],
        //     ),
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Sign out',
                style: TextStyle(color: Colors.black),
              )),
        )

        // Add your account content here
      ],
    ),
  );
}
