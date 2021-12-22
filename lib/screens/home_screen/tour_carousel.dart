import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/screens/detail_screen/tour_detail_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TourCarousel extends StatelessWidget {
  final List<Tour> tourList;
  TourCarousel({Key? key, required this.tourList}) : super(key: key);

  final PageController listController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Top Destinations',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See All'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 320.0,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: listController,
            scrollDirection: Axis.horizontal,
            itemCount: tourList.length,
            itemBuilder: (BuildContext context, int index) {
              Tour tour = tourList[index];
              return GestureDetector(
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => TourDetailScreen(
                //       destination: destination,
                //     ),
                //   ),
                // ),
                // main container
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 240.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 120.0,
                          width: 240.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${tour.destinationIDs.length ~/ 2 + 1} locations',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  tour.description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: tour.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  height: 180.0,
                                  width: 200.0,
                                  image: Image.memory(base64Decode(tour.img))
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    tour.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 12.0,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 2.0),
                                      Text(
                                        tour.price,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SmoothPageIndicator(
            controller: listController,
            count: tourList.isNotEmpty ? (tourList.length - 1).round() : 1,
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(0xFF8a8a8a),
              dotColor: Color(0xFFababab),
              dotHeight: 4.8,
              dotWidth: 6,
              spacing: 4.8,
            ))
      ],
    );
  }
}
