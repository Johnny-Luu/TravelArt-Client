import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/tourgroup_model.dart';
import 'package:travelapp/screens/confirm_info_screen/confirm_info_screen.dart';

class TourGroupItem extends StatelessWidget {
  final TourGroup tourGroup;
  final String image;
  final int type;

  const TourGroupItem({
    Key? key,
    required this.tourGroup,
    required this.image,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(90.0, 20.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tourGroup.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5.0),
                  // start & end date
                  Row(
                    children: [
                      Text(
                        formatDate(
                          tourGroup.startDate,
                          [dd, '/', mm, '/', yyyy],
                        ),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      const Image(
                        width: 18.0,
                        image: AssetImage(
                          "assets/icons/icon-paper-plane.png",
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        formatDate(
                          tourGroup.endDate,
                          [dd, '/', mm, '/', yyyy],
                        ),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // tour guide
                  Row(
                    children: [
                      const Image(
                        width: 18.0,
                        image: AssetImage(
                          "assets/icons/icon-tourist-guide.png",
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        tourGroup.tourLeaderName,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  // tour deputy
                  Row(
                    children: [
                      const Image(
                        width: 18.0,
                        image: AssetImage(
                          "assets/icons/icon-hat.png",
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        tourGroup.tourDeputyName,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Image
          Positioned(
            left: 10.0,
            top: 15.0,
            bottom: 15.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                width: 110.0,
                height: 200.0,
                image: Image.memory(base64Decode(image)).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Book button
          Positioned(
            right: 10.0,
            bottom: 0.0,
            child: type == 1
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ConfirmInfoScreen(tourId: tourGroup.id),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: const Offset(1.0, 2.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Text(
                        "Book",
                        style: GoogleFonts.roboto(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : type == 2
                    // joined button
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                        child: Text(
                          "Joined",
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )
                    // requested button
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3F2FFF),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                        child: Text(
                          "Requested",
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
          ),
          // slot
          Positioned(
            right: 30.0,
            top: 10.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tourGroup.customerListSplited.length.toString() + "/",
                  style: GoogleFonts.roboto(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                Text(
                  tourGroup.slot.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
