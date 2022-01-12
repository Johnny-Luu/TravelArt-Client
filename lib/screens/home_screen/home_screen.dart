import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/screens/home_screen/destination_carousel.dart';
import 'package:travelapp/screens/home_screen/tour_carousel.dart';
import 'package:travelapp/screens/home_screen/hotel_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/screens/login_screen/login_screen.dart';
import 'package:travelapp/screens/profile_screen/profile_screen.dart';
import 'package:travelapp/services/customer_services.dart';
import 'package:travelapp/services/destination_services.dart';
import 'package:travelapp/services/tour_services.dart';
import 'package:travelapp/services/user_services.dart';

class HomeScreen extends StatefulWidget {
  final Function callbackSetNavbar;
  const HomeScreen({Key? key, required this.callbackSetNavbar})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tourServices = TourService();
  var destinationService = DestinationService();
  List<Tour> tourList = [];
  List<Destination> destinationList = [];

  final ScrollController _scrollController = ScrollController();
  var isLoading = true;

  void loadData() async {
    tourList = await tourServices.getAllTours();
    destinationList = await destinationService.getFirstFiveDestinations();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        widget.callbackSetNavbar(false);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse)  {
        widget.callbackSetNavbar(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Image(image: AssetImage('assets/icons/icon-menu.png')),
                SizedBox(width: 10),
                Text(
                  "Ready to start new journey?",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                Icon(
                  FontAwesomeIcons.bell,
                  size: 22,
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
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
                Row(
                  children: [
                    Text(
                      'the nature',
                      style: GoogleFonts.playfairDisplay(
                        color: Theme.of(context).primaryColor,
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Image(
                      width: 32,
                      color: Theme.of(context).primaryColor,
                      image: const AssetImage('assets/icons/icon-plane.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : destinationList.isNotEmpty
                  ? DestinationCarousel(destinationList: destinationList)
                  : Container(),
          const SizedBox(height: 20.0),
          tourList.isNotEmpty ? TourCarousel(tourList: tourList) : Container(),
          const SizedBox(height: 20.0),
          HotelCarousel(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
