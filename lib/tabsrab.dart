import 'package:flutter/material.dart';
import 'package:trendview2/DrawerNew.dart';
import 'package:trendview2/Frostedglass.dart';
import 'package:trendview2/categoryviewall.dart';
import 'package:trendview2/login.dart';
import 'package:trendview2/setting_sri.dart';
import 'categorycard1.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabNames = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  final List<String> id = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF303030),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyLogin(),
              ),
            );
          },
        ),
        actions: [
          Builder(builder: (context) {
            return CircleAvatar(
              backgroundColor: Colors.white12,
              child: IconButton(
                  icon: const Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  }),
            );
          }),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: Colors.white12,
              child: IconButton(
                icon: const Icon(Icons.settings_rounded, color: Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    builder: (BuildContext context) {
                      return FrostedGlassBox(
                        theWidth: MediaQuery.of(context).size.width,
                        theHeight: MediaQuery.of(context).size.height * 0.7,
                        theChild: settingsContent(context),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(213, 42, 42, 42),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontFamily: 'FormaDJRMicro',
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Color.fromARGB(205, 219, 225, 227),
                            height: 1,
                            letterSpacing: -1,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryViewAll(
                                    id: id[_tabController.index]),
                              ),
                            );
                          },
                          child: Container(
                            color: const Color.fromARGB(192, 115, 146, 230),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  color: Color.fromARGB(236, 255, 255, 255),
                                  height: 1,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 47,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _tabController.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 16 : 23, top: 7),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _tabController.index = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: _tabController.index == index
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _tabNames[index],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: _tabController.index == index
                                          ? FontWeight.w700
                                          : FontWeight.w300,
                                      color: _tabController.index == index
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: 'SF Pro Display',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                      _tabController.length,
                      (index) => SingleChildScrollView(
                            child: ApiTabView(
                                category: _tabNames[index].toLowerCase()),
                          )),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const Drawer(
        child: AccountSettingsDrawer(),
      ),
    );
  }
}
