import 'package:flutter/material.dart';
import 'package:trendview2/setting_sri.dart';
import 'menu_body_sri.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuState();
}

class _MenuState extends State<MenuScreen> {
  bool _isSettingsPanel = true;

  void _showBottomSheet(bool isSettings) {
    setState(() {
      _isSettingsPanel = isSettings;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              _isSettingsPanel ? "Settings" : "Account",
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: _isSettingsPanel
                          ? settingsContent(context)
                          : personContent(context),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600, // Match with body color
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(204, 0, 0, 0), // Same as body color
        elevation: 0, // Remove shadow
        iconTheme: const IconThemeData(
          color: Colors.white, // Change pop arrow color to white
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2.0),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.settings_rounded, color: Colors.black),
                  onPressed: () => _showBottomSheet(true),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2.0),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.person_sharp, color: Colors.black),
                  onPressed: () => _showBottomSheet(false),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Close panel if open (handled by modal bottom sheet)
        },
        child: Container(
          // color: Color.fromARGB(204, 0, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/blurr_greenlight.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: buildListItems(context, listItems),
          ),
        ),
      ),
    );
  }
}
