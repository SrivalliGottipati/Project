import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trendview2/login.dart';
import 'package:trendview2/secrets.dart';

class AccountSettingsDrawer extends StatefulWidget {
  const AccountSettingsDrawer({super.key});

  @override
  _AccountSettingsDrawerState createState() => _AccountSettingsDrawerState();
}

class _AccountSettingsDrawerState extends State<AccountSettingsDrawer> {
  bool _obscurePassword = true;
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85, // Wider drawer
      color: const Color(0xFF1E1E1E),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildAvatar(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          didSkip ? 'Guest' : capitalize(final_user),
                          style: TextStyle(
                              fontFamily: 'FormaDJRMicro',
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromARGB(205, 219, 225, 227),
                              letterSpacing: 1),
                        ),
                        Text(
                          didSkip ? 'Not Registered' : 'Premium Member',
                          style: TextStyle(
                            color: didSkip ? Colors.red : Colors.amber,
                            fontSize: 16,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ACCOUNT INFORMATION',
                style: TextStyle(
                  fontFamily: 'FormaDJRMicro',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromARGB(205, 219, 225, 227),
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (didSkip)
                    _buildNotRegisteredContainer()
                  else ...[
                    _buildInfoTile(CupertinoIcons.mail, 'Email', final_email),
                    const SizedBox(height: 10),
                    _buildInfoTile(
                        CupertinoIcons.person, 'Username', final_user),
                    const SizedBox(height: 10),
                    _buildPasswordTile(),
                  ],
                  const SizedBox(height: 20),
                  _buildSwitchTile(
                    'Notifications',
                    _notificationsEnabled,
                    (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildSwitchTile(
                    'Dark Mode',
                    _darkModeEnabled,
                    (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionTile(CupertinoIcons.doc_text, 'Terms of Service'),
                  const SizedBox(height: 10),
                  _buildActionTile(
                      CupertinoIcons.lock_shield, 'Privacy Policy'),
                  const SizedBox(height: 20),
                  _buildSignOutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotRegisteredContainer() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Not Registered',
            style: TextStyle(
              fontFamily: 'FormaDJRMicro',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromARGB(205, 219, 225, 227),
              height: 1,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please sign in or create an account to access all features.',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Color.fromARGB(236, 255, 255, 255),
              height: 1,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyLogin()),
              );
            },
            child: Text(
              'Sign In / Register',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: Color.fromARGB(236, 255, 255, 255),
                height: 1,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(192, 115, 146, 230),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[800],
        backgroundImage: const NetworkImage('https://picsum.photos/200'),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          value,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(236, 255, 255, 255),
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTile() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: const Icon(CupertinoIcons.lock, color: Colors.white70),
        title: const Text('Password', style: TextStyle(color: Colors.white)),
        subtitle: Text(
          _obscurePassword ? '••••••••' : final_pass,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(235, 255, 255, 255),
            letterSpacing: 1,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            _obscurePassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w300,
            fontSize: 15,
            color: Color.fromARGB(236, 255, 255, 255),
            height: 1,
            letterSpacing: 2,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Color.fromARGB(192, 115, 146, 230),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w300,
            fontSize: 15,
            color: Color.fromARGB(236, 255, 255, 255),
            height: 1,
            letterSpacing: 2,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
        onTap: () {
          // Handle tap action
        },
      ),
    );
  }

  Widget _buildSignOutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyLogin(),
          ),
        );
      },
      child: const Text('Sign Out', style: TextStyle(fontSize: 18)),
    );
  }
}

String capitalize(String s) =>
    s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}' : s;
