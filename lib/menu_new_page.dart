import 'package:flutter/material.dart';

late String value;

class MenuNewPage extends StatefulWidget {
  const MenuNewPage({super.key, required String value});

  @override
  State<MenuNewPage> createState() => _MenuNewPageState();
}

class _MenuNewPageState extends State<MenuNewPage> {
  @override
  Widget build(BuildContext context) {
    print(value);
    return const Scaffold();
  }
}
