import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/screens/home_screen/home_screen.dart';
import 'package:travelapp/screens/profile_screen/profile_screen.dart';
import 'package:travelapp/screens/search_screen/search_screen.dart';
import 'package:travelapp/services/customer_services.dart';
import 'package:travelapp/services/destination_services.dart';
import 'package:travelapp/services/tour_services.dart';

import 'models/tour_model.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentTab = 0;
  bool _hideNavbar = false;
  late var tabs;

  void changeBottomNavbarVisibility(bool value) {
    setState(() {
      _hideNavbar = value;
    });
  }

  @override
  void initState() {
    super.initState();
    tabs = [
      const HomeScreen(),
      const SearchScreen(),
      ProfileScreen(callbackSetNavbar: changeBottomNavbarVisibility),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentTab,
        children: tabs,
      ),
      bottomNavigationBar: _hideNavbar
          ? const SizedBox()
          : Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 20,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: SalomonBottomBar(
                  selectedItemColor: Theme.of(context).primaryColor,
                  currentIndex: _currentTab,
                  onTap: (int value) {
                    setState(() {
                      _currentTab = value;
                    });
                  },
                  items: [
                    SalomonBottomBarItem(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/icon-home-outline.png'),
                        size: 28.0,
                      ),
                      activeIcon: const ImageIcon(
                        AssetImage('assets/icons/icon-home-fill.png'),
                        size: 28.0,
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SalomonBottomBarItem(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/icon-search.png'),
                        size: 28.0,
                      ),
                      title: const Text(
                        'Search',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SalomonBottomBarItem(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/icon-person-outline.png'),
                        size: 28.0,
                      ),
                      activeIcon: const ImageIcon(
                        AssetImage('assets/icons/icon-person-fill.png'),
                        size: 28.0,
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
