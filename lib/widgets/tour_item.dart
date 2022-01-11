import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/screens/detail_screen/tour_detail_screen.dart';

class TourItem extends StatelessWidget {
  final Tour tour;
  final Image tourImg;
  final int type;

  TourItem({
    Key? key,
    required this.tour,
    required this.tourImg,
    required this.type,
  }) : super(key: key);

  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: type == 1 ? 320 : 350,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TourDetailScreen(
              tour: tour,
              tourImg: tourImg,
              type: type,
            ),
          ),
        ),
        // main container
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: type == 1 ? 240.0 : 300.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                bottom: 15.0,
                child: Container(
                  height: type == 1 ? 120.0 : 150.0,
                  width: type == 1 ? 240.0 : 320.0,
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
                          '${tour.destinationIDList.length} locations',
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
                      tag: type == 1 ? tour.id : tour.name,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          height: type == 1 ? 180.0 : 200.0,
                          width: type == 1 ? 200.0 : 280.0,
                          image: tourImg.image,
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: type == 1 ? 24.0 : 28.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.dollarSign,
                                size: type == 1 ? 12.0 : 16.0,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 2.0),
                              Text(
                                '${formatCurrency.format(int.parse(tour.price))} VND',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: type == 1 ? 12.0 : 16.0,
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
      ),
    );
    ;
  }
}
