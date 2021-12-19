import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/screens/home_screen/tour_carousel.dart';
import 'package:travelapp/screens/home_screen/hotel_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: const [
                    Icon(FontAwesomeIcons.bars),
                    SizedBox(width: 10),
                    Text(
                      "Hello, User",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 15.0,
                  backgroundImage:
                      NetworkImage('http://i.imgur.com/zL4Krbz.jpg'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 58,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'the nature',
                  style: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).primaryColor,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          TourCarousel(),
          const SizedBox(height: 20.0),
          HotelCarousel(),
          const SizedBox(height: 20.0),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          currentIndex: _currentTab,
          onTap: (int value) {
            setState(() {
              _currentTab = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 30.0,
              ),
              activeIcon: Icon(
                Icons.home_rounded,
                size: 30.0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              activeIcon: Icon(
                Icons.search_rounded,
                size: 30.0,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 30.0,
              ),
              activeIcon: Icon(
                Icons.person_rounded,
                size: 30.0,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
