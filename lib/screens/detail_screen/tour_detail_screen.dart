import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/activity_model.dart';
import 'package:travelapp/models/comment_model.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/screens/detail_screen/rating_tab.dart';
import 'package:travelapp/services/destination_services.dart';
import 'package:travelapp/widgets/comment_item.dart';
import 'package:travelapp/widgets/planning_item.dart';

import 'detail_tab.dart';

class TourDetailScreen extends StatefulWidget {
  final Tour tour;
  final Image tourImg;
  final int type;

  const TourDetailScreen({
    Key? key,
    required this.tour,
    required this.tourImg,
    required this.type,
  }) : super(key: key);

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var destinationService = DestinationService();
  List<Destination> destinations = [];
  String province = '';

  void loadDestinations() async {
    for (var des in widget.tour.destinationIDList) {
      var destination = await destinationService.getDestinationById(des);
      destinations.add(destination);
    }
    province = destinations[0].province;
    setState(() {});
  }

  void updateRatingList(List<Comment> list) {
    setState(() {
      widget.tour.ratingList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDestinations();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              // Main image
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.type == 1 ? widget.tour.id : widget.tour.name,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image(
                      image: widget.tourImg.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // buttons row
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.sortAmountDown),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // name and province
              Positioned(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.tour.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 15.0,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          province,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          DefaultTabController(
            length: 3,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue[800],
              unselectedLabelColor: Colors.grey,
              labelStyle: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.blue[800]!,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 75.0),
              ),
              tabs: const [
                Tab(child: Text("Details")),
                Tab(child: Text("Plan")),
                Tab(child: Text("Rating")),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // description section
                DetailTab(tour: widget.tour),
                // planning section
                destinations.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(15.0),
                        itemCount: widget.tour.destinationIDList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Destination destination = destinations[index];
                          return PlanningItem(
                            destination: destination,
                            index: index + 1,
                            type: 1,
                          );
                        },
                      )
                    : const Center(child: Text("No destination")),
                // rating section
                RatingTab(
                  tour: widget.tour,
                  callbackUpdateRatingDetail: updateRatingList,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
